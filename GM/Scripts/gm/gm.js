/// <reference path="../typings/angularjs/angular.d.ts" />
/// <reference path="../typings/angularjs/angular-route.d.ts" />
/// <reference path="../typings/angular-material/angular-material.d.ts" />
var GM;
(function (GM) {
    "use strict";
    GM.fbAppId = "1574477942882037";
    GM.googleApiKey = "AIzaSyCtuJp3jsaJp3X6U8ZS_X5H8omiAw5QaHg";
    GM.debugEnabled = true;
    GM.authenticated = false;
    var Database;
    (function (Database) {
        var Service = (function () {
            function Service($q, $http, $log) {
                this.$q = $q;
                this.$http = $http;
                this.$log = $log;
            }
            Service.prototype.execute = function (name, parameters) {
                var _this = this;
                if (parameters === void 0) { parameters = {}; }
                var procedure = { name: name, parameters: parameters }, deferred = this.$q.defer();
                if (this.UserId) {
                    parameters["UserId"] = { value: this.UserId };
                }
                this.$log.debug("gm:execute", procedure);
                this.$http.post("execute.ashx", procedure).then(function (response) {
                    deferred.resolve(response.data);
                    if (!response.data.success) {
                        _this.$log.warn(response.data.data);
                    }
                }, function (response) {
                    deferred.resolve({ success: false, data: response.statusText });
                    _this.$log.warn(response.status, response.statusText);
                });
                return deferred.promise;
            };
            Service.prototype.FetchGenres = function () {
                return this.execute("apiGenres");
            };
            Service.prototype.FetchStyles = function (genreId) {
                return this.execute("apiStyles", { GenreId: { value: genreId } });
            };
            Service.$inject = ["$q", "$http", "$log"];
            return Service;
        }());
        Database.Service = Service;
    })(Database = GM.Database || (GM.Database = {}));
    var Facebook;
    (function (Facebook) {
        var Service = (function () {
            function Service($database, $log) {
                this.$database = $database;
                this.$log = $log;
            }
            Service.prototype.Login = function () {
                var _this = this;
                var fail = function () {
                    delete _this.$database.UserId;
                    _this.$log.debug("gm:login:fail");
                };
                try {
                    FB.login(function (response) {
                        if (response.status === "connected") {
                            FB.api("/me", { fields: ["id", "first_name", "last_name", "gender"] }, function (response) {
                                _this.$database.execute("apiLogin", {
                                    UserId: { value: response.id },
                                    Forename: { value: response.first_name },
                                    Surname: { value: response.last_name },
                                    Gender: { value: response.gender }
                                }).then(function (response) {
                                    if (response.success) {
                                        _this.$database.UserId = response.data.UserId;
                                    }
                                    _this.$log.debug("gm:login:success");
                                });
                            });
                        }
                        else
                            fail();
                    });
                }
                catch (ex) {
                    fail();
                }
            };
            Service.prototype.Logout = function () {
                try {
                    FB.logout(angular.noop);
                }
                finally {
                    delete this.$database.UserId;
                    this.$log.debug("gm:logout");
                }
            };
            Service.$inject = ["$database", "$log"];
            return Service;
        }());
        Facebook.Service = Service;
    })(Facebook = GM.Facebook || (GM.Facebook = {}));
    var VideoIdValidator;
    (function (VideoIdValidator) {
        function VideoIdFromUrl(url) {
            var formats = ["youtube\.com\/.*?v=([^?&\/]+)", "youtu\.be\/([^?&\/]+)"], videoId;
            for (var i = 0; i < formats.length; i++) {
                var rx = new RegExp(formats[i], "i");
                if (rx.test(url)) {
                    videoId = rx.exec(url)[1];
                    break;
                }
            }
            return videoId;
        }
        VideoIdValidator.VideoIdFromUrl = VideoIdFromUrl;
        function DirectiveFactory() {
            var factory = function ($http, $q) {
                return {
                    restrict: "A",
                    scope: { video: "=videoIdValidator" },
                    require: ["ngModel"],
                    link: function ($scope, $element, $attrs, controllers) {
                        controllers[0].$parsers.unshift(function (viewValue) {
                            if (controllers[0].$isEmpty(viewValue)) {
                                delete $scope.video;
                            }
                            return viewValue;
                        });
                        controllers[0].$asyncValidators["videoId"] = function (modelValue, viewValue) {
                            var videoId = VideoIdFromUrl(modelValue || viewValue), $deferred = $q.defer(), resolve = function (video) {
                                $scope.video = video;
                                $deferred.resolve(true);
                            }, reject = function () {
                                delete $scope.video;
                                $deferred.reject(false);
                            };
                            if (!videoId) {
                                reject();
                                return $deferred.promise;
                            }
                            $http.get("https://www.googleapis.com/youtube/v3/videos?id=" + videoId + "&key=" + GM.googleApiKey + "&part=snippet")
                                .then(function (response) {
                                try {
                                    var item = response.data.items[0];
                                    if (item.id !== videoId) {
                                        reject();
                                        return;
                                    }
                                    resolve({ id: item.id, title: item.snippet.title, thumbnail: item.snippet.thumbnails.medium.url });
                                }
                                catch (err) {
                                    reject();
                                }
                            }, function () { reject(); });
                            return $deferred.promise;
                        };
                    }
                };
            };
            factory.$inject = ["$http", "$q"];
            return factory;
        }
        VideoIdValidator.DirectiveFactory = DirectiveFactory;
    })(VideoIdValidator = GM.VideoIdValidator || (GM.VideoIdValidator = {}));
    var Home;
    (function (Home) {
        var Controller = (function () {
            function Controller($scope, $facebook, $database, $location) {
                var _this = this;
                this.$scope = $scope;
                this.$facebook = $facebook;
                this.$database = $database;
                this.$location = $location;
                $database.execute("apiUserSettings")
                    .then(function (response) {
                    _this.Genre = response.data.Genre;
                    _this.Style = response.data.Style;
                    _this.FetchGenres();
                    _this.FetchStyles();
                    _this.FetchVideos();
                });
            }
            Object.defineProperty(Controller.prototype, "LoggedIn", {
                get: function () { return (this.$database.UserId) ? true : false; },
                enumerable: true,
                configurable: true
            });
            Controller.prototype.FetchGenres = function () {
                var _this = this;
                this.$database.FetchGenres().then(function (response) { _this.$scope.genres = response.data.Genres; });
            };
            Controller.prototype.FetchStyles = function () {
                var _this = this;
                if (!this.Genre) {
                    delete this.$scope.styles;
                    return;
                }
                this.$database.FetchStyles(this.Genre.Id).then(function (response) { _this.$scope.styles = response.data.Styles; });
            };
            Controller.prototype.SetGenre = function (genre) {
                if (genre) {
                    this.Genre = genre;
                }
                else {
                    delete this.Genre;
                }
                delete this.Style;
                this.FetchStyles();
                this.FetchVideos();
            };
            Controller.prototype.SetStyle = function (style) {
                if (style) {
                    this.Style = style;
                }
                else {
                    delete this.Style;
                }
                this.FetchVideos();
            };
            Controller.prototype.FetchVideos = function () {
                var _this = this;
                var parameters = {};
                if (this.Genre) {
                    parameters["GenreId"] = { value: this.Genre.Id };
                    if (this.Style) {
                        parameters["StyleId"] = { value: this.Style.Id };
                    }
                }
                ;
                this.$database.execute("apiVideos", parameters)
                    .then(function (response) { _this.$scope.videos = response.data.Videos; });
            };
            Controller.$inject = ["$scope", "$facebook", "$database", "$location"];
            return Controller;
        }());
        Home.Controller = Controller;
    })(Home = GM.Home || (GM.Home = {}));
    var Video;
    (function (Video) {
        var Controller = (function () {
            function Controller($scope, $database, $routeParams) {
                var _this = this;
                this.$scope = $scope;
                this.$database = $database;
                this.$routeParams = $routeParams;
                $database.execute("apiVideo", {
                    VideoId: { value: $routeParams["videoId"] },
                    GenreId: { value: $routeParams["genreId"] }
                }).then(function (response) {
                    $scope.video = response.data.Video;
                    var player = new YT.Player('player', {
                        videoId: $scope.video.VideoId,
                        height: "390",
                        width: "640",
                        events: { onReady: function (event) { event.target.playVideo(); } }
                    });
                    _this.FetchReviews();
                });
            }
            Controller.prototype.FetchReviews = function () {
                var _this = this;
                this.$database.execute("apiReviews", {
                    VideoId: { value: this.$routeParams["videoId"] },
                    GenreId: { value: this.$routeParams["genreId"] }
                }).then(function (response) { _this.$scope.reviews = response.data.Reviews; });
            };
            Controller.prototype.Review = function (styleId, like) {
                var _this = this;
                this.$database.execute("apiReview", {
                    VideoId: { value: this.$routeParams["videoId"] },
                    GenreId: { value: this.$routeParams["genreId"] },
                    styleId: { value: styleId },
                    Like: { value: like }
                }).then(function (response) { _this.$scope.reviews = response.data.Reviews; });
                ;
            };
            Controller.$inject = ["$scope", "$database", "$routeParams"];
            return Controller;
        }());
        Video.Controller = Controller;
    })(Video = GM.Video || (GM.Video = {}));
    var Recommend;
    (function (Recommend) {
        var Controller = (function () {
            function Controller($scope, $database, $http, $location) {
                this.$scope = $scope;
                this.$database = $database;
                this.$http = $http;
                this.$location = $location;
                this.FetchGenres();
            }
            Controller.prototype.FetchGenres = function () {
                var _this = this;
                this.$database.FetchGenres().then(function (response) { _this.Genres = response.data.Genres; });
            };
            Controller.prototype.FetchStyles = function () {
                var _this = this;
                this.$database.FetchStyles(this.GenreId).then(function (response) { _this.Styles = response.data.Styles; });
            };
            Object.defineProperty(Controller.prototype, "SelectedStyles", {
                get: function () {
                    if (!angular.isArray(this.Styles)) {
                        return;
                    }
                    var found;
                    for (var i = 0; i < this.Styles.length; i++) {
                        if (this.Styles[i].Checked) {
                            found = true;
                            break;
                        }
                    }
                    return found;
                },
                enumerable: true,
                configurable: true
            });
            Controller.prototype.Submit = function () {
                var _this = this;
                this.$database.execute("apiRecommend", {
                    VideoId: { value: this.$scope.video.id },
                    Title: { value: this.$scope.video.title },
                    Thumbnail: { value: this.$scope.video.thumbnail },
                    Styles: { value: { data: this.Styles }, isObject: true }
                })
                    .then(function (response) {
                    if (response.success) {
                        _this.$location.path("/video/" + _this.$scope.video.id + "/" + _this.GenreId);
                    }
                });
            };
            Controller.$inject = ["$scope", "$database", "$http", "$location"];
            return Controller;
        }());
        Recommend.Controller = Controller;
    })(Recommend = GM.Recommend || (GM.Recommend = {}));
})(GM || (GM = {}));
var gm = angular.module("gm", ["ngRoute", "ngAnimate", "ngAria", "ngMessages", "ngSanitize", "ngMaterial"]);
gm.service("$database", GM.Database.Service);
gm.service("$facebook", GM.Facebook.Service);
gm.directive("videoIdValidator", GM.VideoIdValidator.DirectiveFactory());
gm.config(["$mdThemingProvider", "$routeProvider", "$logProvider", function ($mdThemingProvider, $routeProvider, $logProvider) {
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
gm.run(["$window", "$log", function ($window, $log) {
        $window.fbAsyncInit = function () {
            FB.init({ appId: GM.fbAppId, version: "v2.7" });
            $log.debug("gm:fbAsyncInit");
        };
        //GM.authenticated = document.getElementById("gm-script").getAttribute("data-authenticated").toLowerCase() === "true";
        //if (GM.authenticated) { GM.Database.userId = document.getElementById("gm-script").getAttribute("data-id"); }
    }]);
//# sourceMappingURL=gm.js.map