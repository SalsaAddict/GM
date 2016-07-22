/// <reference path="../typings/angularjs/angular.d.ts" />
/// <reference path="../typings/angularjs/angular-route.d.ts" />
/// <reference path="../typings/angular-material/angular-material.d.ts" />

declare let FB: any, YT: any;

module GM {
    "use strict";
    export const fbAppId: string = "1574477942882037";
    export const googleApiKey: string = "AIzaSyCtuJp3jsaJp3X6U8ZS_X5H8omiAw5QaHg";
    export const debugEnabled: boolean = true;
    export var authenticated: boolean = false;
    export interface IWindowService extends angular.IWindowService { fbAsyncInit: Function; }
    export interface IResponse { success: boolean; data: any; }
    export interface IVideo { id: string; title: string; thumbnail: string; }
    export module Database {
        export var userId: string;
        export interface IParameter { value: any; isObject?: boolean; }
        export interface IParameters { [name: string]: IParameter; }
        export interface IHttpSuccess { data: IResponse }
        export interface IHttpError { status: number; statusText: string; }
        export interface IProcedure { name: string; parameters?: IParameters; }
        export class Service {
            static $inject: string[] = ["$q", "$http", "$log"];
            constructor(
                private $q: angular.IQService,
                private $http: angular.IHttpService,
                private $log: angular.ILogService) { }
            public UserId: string;
            public execute(name: string, parameters: IParameters = {}): angular.IPromise<IResponse> {
                let procedure: IProcedure = { name: name, parameters: parameters },
                    deferred: angular.IDeferred<IResponse> = this.$q.defer();
                if (this.UserId) { parameters["UserId"] = { value: this.UserId }; }
                this.$log.debug("gm:execute", procedure);
                this.$http.post("execute.ashx", procedure).then(
                    (response: IHttpSuccess) => {
                        deferred.resolve(response.data);
                        if (!response.data.success) { this.$log.warn(response.data.data); }
                    },
                    (response: IHttpError) => {
                        deferred.resolve({ success: false, data: response.statusText });
                        this.$log.warn(response.status, response.statusText);
                    });
                return deferred.promise;
            }
            public FetchGenres(): angular.IPromise<IResponse> {
                return this.execute("apiGenres");
            }
            public FetchStyles(genreId: string): angular.IPromise<IResponse> {
                return this.execute("apiStyles", { GenreId: { value: genreId } });
            }
        }
    }
    export module Facebook {
        interface IAuthResponse {
            status: "connected" | "not_authorized" | "unknown";
            authResponse: {
                accessToken: string;
                expiresIn: string;
                signedRequest: string;
                userID: string;
            }
        }
        interface IUser { id: string; first_name: string; last_name: string; gender: "male" | "female"; }
        export class Service {
            static $inject: string[] = ["$database", "$log"];
            constructor(
                private $database: Database.Service,
                private $log: angular.ILogService) { }
            public Login(): void {
                let fail: Function = (): void => {
                    delete this.$database.UserId;
                    this.$log.debug("gm:login:fail");
                }
                try {
                    FB.login((response: IAuthResponse) => {
                        if (response.status === "connected") {
                            FB.api("/me", { fields: ["id", "first_name", "last_name", "gender"] }, (response: IUser) => {
                                this.$database.execute("apiLogin", {
                                    UserId: { value: response.id },
                                    Forename: { value: response.first_name },
                                    Surname: { value: response.last_name },
                                    Gender: { value: response.gender }
                                }).then((response: IResponse) => {
                                    if (response.success) { this.$database.UserId = response.data.UserId; }
                                    this.$log.debug("gm:login:success");
                                });
                            });
                        } else fail();
                    });
                }
                catch (ex) { fail(); }
            }
            public Logout(): void {
                try {
                    FB.logout(angular.noop);
                }
                finally {
                    delete this.$database.UserId;
                    this.$log.debug("gm:logout");
                }
            }
        }
    }
    export module VideoIdValidator {
        export function VideoIdFromUrl(url: string): string {
            let formats: string[] = ["youtube\.com\/.*?v=([^?&\/]+)", "youtu\.be\/([^?&\/]+)"], videoId: string;
            for (let i: number = 0; i < formats.length; i++) {
                let rx: RegExp = new RegExp(formats[i], "i");
                if (rx.test(url)) { videoId = rx.exec(url)[1]; break; }
            }
            return videoId;
        }
        export interface IScope extends angular.IScope { video: IVideo }
        export function DirectiveFactory(): angular.IDirectiveFactory {
            let factory: angular.IDirectiveFactory = function (
                $http: angular.IHttpService,
                $q: angular.IQService): angular.IDirective {
                return {
                    restrict: "A",
                    scope: { video: "=videoIdValidator" },
                    require: ["ngModel"],
                    link: function (
                        $scope: IScope,
                        $element: angular.IAugmentedJQuery,
                        $attrs: angular.IAttributes,
                        controllers: [angular.INgModelController]) {
                        controllers[0].$parsers.unshift(function (viewValue: string) {
                            if (controllers[0].$isEmpty(viewValue)) { delete $scope.video; }
                            return viewValue;
                        });
                        controllers[0].$asyncValidators["videoId"] = function (modelValue: string, viewValue: string) {
                            let videoId: string = VideoIdFromUrl(modelValue || viewValue),
                                $deferred: angular.IDeferred<boolean> = $q.defer(),
                                resolve: Function = function (video: IVideo) {
                                    $scope.video = video;
                                    $deferred.resolve(true);
                                },
                                reject: Function = function () {
                                    delete $scope.video;
                                    $deferred.reject(false);
                                };
                            if (!videoId) { reject(); return $deferred.promise }
                            $http.get("https://www.googleapis.com/youtube/v3/videos?id=" + videoId + "&key=" + googleApiKey + "&part=snippet")
                                .then(function (response: any): void {
                                    try {
                                        let item: any = response.data.items[0];
                                        if (item.id !== videoId) { reject(); return; }
                                        resolve({ id: item.id, title: item.snippet.title, thumbnail: item.snippet.thumbnails.medium.url });
                                    }
                                    catch (err) { reject(); }
                                }, function () { reject(); });
                            return $deferred.promise;
                        }
                    }
                }
            };
            factory.$inject = ["$http", "$q"];
            return factory;
        }
    }
    export module Home {
        interface IScope extends angular.IScope { genres: any[]; styles: any[]; videos: any[]; }
        export class Controller {
            static $inject: string[] = ["$scope", "$facebook", "$database", "$location"];
            constructor(
                private $scope: IScope,
                public $facebook: Facebook.Service,
                private $database: Database.Service,
                private $location: angular.ILocationService) {
                $database.execute("apiUserSettings")
                    .then((response: IResponse) => {
                        this.Genre = response.data.Genre;
                        this.Style = response.data.Style;
                        this.FetchGenres();
                        this.FetchStyles();
                        this.FetchVideos();
                    });
            }
            public get LoggedIn(): boolean { return (this.$database.UserId) ? true : false; }
            public FetchGenres() {
                this.$database.FetchGenres().then((response: IResponse) => { this.$scope.genres = response.data.Genres; });
            }
            public FetchStyles() {
                if (!this.Genre) { delete this.$scope.styles; return; }
                this.$database.FetchStyles(this.Genre.Id).then((response: IResponse) => { this.$scope.styles = response.data.Styles; });
            }
            public Genre: any;
            public SetGenre(genre?: any) {
                if (genre) { this.Genre = genre; } else { delete this.Genre; }
                delete this.Style;
                this.FetchStyles();
                this.FetchVideos();
            }
            public Style: any;
            public SetStyle(style?: any) {
                if (style) { this.Style = style; } else { delete this.Style; }
                this.FetchVideos();
            }
            public FetchVideos() {
                let parameters: Database.IParameters = {};
                if (this.Genre) {
                    parameters["GenreId"] = { value: this.Genre.Id }
                    if (this.Style) {
                        parameters["StyleId"] = { value: this.Style.Id }
                    }
                };
                this.$database.execute("apiVideos", parameters)
                    .then((response: IResponse) => { this.$scope.videos = response.data.Videos; });
            }
        }
    }
    export module Video {
        interface IScope extends angular.IScope { video: any; reviews: any; }
        export class Controller {
            static $inject: string[] = ["$scope", "$database", "$routeParams"];
            constructor(
                private $scope: IScope,
                private $database: Database.Service,
                private $routeParams: angular.route.IRouteParamsService) {
                $database.execute("apiVideo", {
                    VideoId: { value: $routeParams["videoId"] },
                    GenreId: { value: $routeParams["genreId"] }
                }).then((response: IResponse) => {
                    $scope.video = response.data.Video;
                    let player = new YT.Player('player', {
                        videoId: $scope.video.VideoId,
                        height: "390",
                        width: "640",
                        events: { onReady: function (event: any) { event.target.playVideo(); } }
                    });
                    this.FetchReviews();
                });
            }
            public FetchReviews(): void {
                this.$database.execute("apiReviews", {
                    VideoId: { value: this.$routeParams["videoId"] },
                    GenreId: { value: this.$routeParams["genreId"] }
                }).then((response: IResponse) => { this.$scope.reviews = response.data.Reviews; });
            }
            public Review(styleId: string, like: boolean) {
                this.$database.execute("apiReview", {
                    VideoId: { value: this.$routeParams["videoId"] },
                    GenreId: { value: this.$routeParams["genreId"] },
                    styleId: { value: styleId },
                    Like: { value: like }
                }).then((response: IResponse) => { this.$scope.reviews = response.data.Reviews; });;
            }
        }
    }
    export module Recommend {
        export interface IScope extends angular.IScope { video: IVideo; }
        export class Controller {
            static $inject: string[] = ["$scope", "$database", "$http", "$location"];
            constructor(
                private $scope: IScope,
                private $database: GM.Database.Service,
                private $http: angular.IHttpService,
                private $location: angular.ILocationService) {
                this.FetchGenres();
            }
            public Url: string;
            public Video: IVideo;
            public GenreId: any; public Genres: any[];
            public FetchGenres(): void {
                this.$database.FetchGenres().then((response: IResponse) => { this.Genres = response.data.Genres; });
            }
            public StyleId: any; public Styles: any[];
            public FetchStyles(): void {
                this.$database.FetchStyles(this.GenreId).then((response: IResponse) => { this.Styles = response.data.Styles; });
            }
            public get SelectedStyles(): boolean {
                if (!angular.isArray(this.Styles)) { return; }
                let found: boolean;
                for (let i: number = 0; i < this.Styles.length; i++) {
                    if (this.Styles[i].Checked) { found = true; break; }
                }
                return found;
            }
            public Submit(): void {
                this.$database.execute("apiRecommend", {
                    VideoId: { value: this.$scope.video.id },
                    Title: { value: this.$scope.video.title },
                    Thumbnail: { value: this.$scope.video.thumbnail },
                    Styles: { value: { data: this.Styles }, isObject: true }
                })
                    .then((response: IResponse) => {
                        if (response.success) {
                            this.$location.path("/video/" + this.$scope.video.id + "/" + this.GenreId);
                        }
                    });
            }
        }
    }
}

let gm: angular.IModule = angular.module("gm", ["ngRoute", "ngAnimate", "ngAria", "ngMessages", "ngSanitize", "ngMaterial"]);

gm.service("$database", GM.Database.Service);
gm.service("$facebook", GM.Facebook.Service);
gm.directive("videoIdValidator", GM.VideoIdValidator.DirectiveFactory());

gm.config(["$mdThemingProvider", "$routeProvider", "$logProvider", function (
    $mdThemingProvider: angular.material.IThemingProvider,
    $routeProvider: angular.route.IRouteProvider,
    $logProvider: angular.ILogProvider) {
    $mdThemingProvider.theme("default")
        .primaryPalette("blue")
        .accentPalette("indigo")
        .warnPalette("red")
        .backgroundPalette("grey");
    $routeProvider.caseInsensitiveMatch = true;
    $routeProvider
        .when("/home", { templateUrl: "Views/home.html", controller: GM.Home.Controller, controllerAs: "ctrl" })
        .when("/video/:videoId/:genreId", { templateUrl: "Views/video.html", controller: GM.Video.Controller, controllerAs: "ctrl" })
        .when("/recommend", { templateUrl: "Views/recommend.html", controller: GM.Recommend.Controller, controllerAs: "ctrl" })
        .otherwise({ redirectTo: "/home" });
    $logProvider.debugEnabled(GM.debugEnabled);
}]);

gm.run(["$window", "$log", function (
    $window: GM.IWindowService,
    $log: angular.ILogService) {
    $window.fbAsyncInit = function () {
        FB.init({ appId: GM.fbAppId, version: "v2.7" });
        $log.debug("gm:fbAsyncInit");
    }
    //GM.authenticated = document.getElementById("gm-script").getAttribute("data-authenticated").toLowerCase() === "true";
    //if (GM.authenticated) { GM.Database.userId = document.getElementById("gm-script").getAttribute("data-id"); }
}]);