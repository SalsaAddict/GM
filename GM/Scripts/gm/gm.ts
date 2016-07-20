/// <reference path="../typings/angularjs/angular.d.ts" />
/// <reference path="../typings/angularjs/angular-route.d.ts" />
/// <reference path="../typings/angular-material/angular-material.d.ts" />

declare let FB: any, YT: any;

module GM {
    "use strict";
    export const googleApiKey: string = "AIzaSyCtuJp3jsaJp3X6U8ZS_X5H8omiAw5QaHg";
    export const debugEnabled: boolean = true;
    export var authenticated: boolean = false;
    export interface IResponse { success: boolean; data: any; }
    export interface IVideo { id: string; title: string; thumbnail: string; }
    export module Database {
        export interface IParameter { value: any; isObject?: boolean; }
        export interface IParameters { [name: string]: IParameter; }
        export interface IHttpSuccess { data: IResponse }
        export interface IHttpError { status: number; statusText: string; }
        export interface IProcedure {
            name: string;
            parameters?: IParameters;
            type?: "object" | "array" | "singleton" | "value" | "none";
        }
        export class Service {
            static $inject: string[] = ["$q", "$http", "$log"];
            constructor(
                private $q: angular.IQService,
                private $http: angular.IHttpService,
                private $log: angular.ILogService) { }
            public execute(name: string, parameters: IParameters = {}): angular.IPromise<IResponse> {
                let procedure: IProcedure = { name: name, parameters: parameters }
                let deferred: angular.IDeferred<IResponse> = this.$q.defer();
                this.$http.post("execute.ashx", procedure).then(
                    (response: IHttpSuccess) => { deferred.resolve(response.data); },
                    (response: IHttpError) => { deferred.resolve({ success: false, data: response.statusText }); });
                return deferred.promise;
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
    export module Recommend {
        export interface IScope extends angular.IScope { video: IVideo; }
        export class Controller {
            static $inject: string[] = ["$scope", "$database", "$http"];
            constructor(
                private $scope: IScope,
                private $database: GM.Database.Service,
                private $http: angular.IHttpService) {
                this.FetchGenres();
            }
            public Url: string;
            public Video: IVideo;
            public GenreId: any; public Genres: any[];
            public FetchGenres(): void {
                this.$database.execute("apiGenres")
                    .then((response: IResponse) => { this.Genres = response.data.Genres; });
            }
            public StyleId: any; public Styles: any[];
            public FetchStyles(): void {
                this.$database.execute("apiStyles", { GenreId: { value: this.GenreId } })
                    .then((response: IResponse) => { this.Styles = response.data.Styles; });
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
                    Styles: { value: this.Styles, isObject: true }
                })
                    .then((response: IResponse) => {
                        console.log("submitted", response);
                    });
            }
        }
    }
}

let gm: angular.IModule = angular.module("gm", ["ngRoute", "ngAnimate", "ngAria", "ngMessages", "ngSanitize", "ngMaterial"]);

gm.service("$database", GM.Database.Service);
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
        .when("/home", { templateUrl: "Views/home.html" })
        .when("/recommend", {
            templateUrl: "Views/recommend.html", controller: GM.Recommend.Controller, controllerAs: "ctrl"
        })
        .otherwise({ redirectTo: "/home" });
    $logProvider.debugEnabled(GM.debugEnabled);
}]);

gm.run(["$log", function ($log: angular.ILogService) {
    GM.authenticated = document.getElementById("gm-script").getAttribute("data-authenticated").toLowerCase() === "true";
}]);