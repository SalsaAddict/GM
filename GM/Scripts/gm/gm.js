/// <reference path="../typings/angularjs/angular.d.ts" />
/// <reference path="../typings/angularjs/angular-route.d.ts" />
/// <reference path="../typings/angular-material/angular-material.d.ts" />
var GM;
(function (GM) {
    "use strict";
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
                if (parameters === void 0) { parameters = {}; }
                var procedure = { name: name, parameters: parameters }, deferred = this.$q.defer();
                this.$log.debug("gm:execute", procedure);
                this.$http.post("execute.ashx", procedure).then(function (response) { deferred.resolve(response.data); }, function (response) { deferred.resolve({ success: false, data: response.statusText }); });
                return deferred.promise;
            };
            Service.$inject = ["$q", "$http", "$log"];
            return Service;
        }());
        Database.Service = Service;
    })(Database = GM.Database || (GM.Database = {}));
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
    var Video;
    (function (Video) {
        var Controller = (function () {
            function Controller($scope, $database, $routeParams) {
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
                        events: { onReady: function (event) { event.target.playVideo(); } }
                    });
                });
            }
            Controller.$inject = ["$scope", "$database", "$routeParams"];
            return Controller;
        }());
        Video.Controller = Controller;
    })(Video = GM.Video || (GM.Video = {}));
    var Recommend;
    (function (Recommend) {
        var Controller = (function () {
            function Controller($scope, $database, $http) {
                this.$scope = $scope;
                this.$database = $database;
                this.$http = $http;
                this.FetchGenres();
            }
            Controller.prototype.FetchGenres = function () {
                var _this = this;
                this.$database.execute("apiGenres")
                    .then(function (response) { _this.Genres = response.data.Genres; });
            };
            Controller.prototype.FetchStyles = function () {
                var _this = this;
                this.$database.execute("apiStyles", { GenreId: { value: this.GenreId } })
                    .then(function (response) { _this.Styles = response.data.Styles; });
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
                this.$database.execute("apiRecommend", {
                    VideoId: { value: this.$scope.video.id },
                    Title: { value: this.$scope.video.title },
                    Thumbnail: { value: this.$scope.video.thumbnail },
                    Styles: { value: { data: this.Styles }, isObject: true }
                })
                    .then(function (response) {
                    console.log("submitted", response);
                });
            };
            Controller.$inject = ["$scope", "$database", "$http"];
            return Controller;
        }());
        Recommend.Controller = Controller;
    })(Recommend = GM.Recommend || (GM.Recommend = {}));
})(GM || (GM = {}));
var gm = angular.module("gm", ["ngRoute", "ngAnimate", "ngAria", "ngMessages", "ngSanitize", "ngMaterial"]);
gm.service("$database", GM.Database.Service);
gm.directive("videoIdValidator", GM.VideoIdValidator.DirectiveFactory());
gm.config(["$mdThemingProvider", "$routeProvider", "$logProvider", function ($mdThemingProvider, $routeProvider, $logProvider) {
        $mdThemingProvider.theme("default")
            .primaryPalette("blue")
            .accentPalette("indigo")
            .warnPalette("red")
            .backgroundPalette("grey");
        $routeProvider.caseInsensitiveMatch = true;
        $routeProvider
            .when("/home", { templateUrl: "Views/home.html" })
            .when("/video/:videoId/:genreId", { templateUrl: "Views/video.html", controller: GM.Video.Controller, controllerAs: "ctrl" })
            .when("/recommend", { templateUrl: "Views/recommend.html", controller: GM.Recommend.Controller, controllerAs: "ctrl" })
            .otherwise({ redirectTo: "/home" });
        $logProvider.debugEnabled(GM.debugEnabled);
    }]);
gm.run(["$log", function ($log) {
        GM.authenticated = document.getElementById("gm-script").getAttribute("data-authenticated").toLowerCase() === "true";
    }]);
//# sourceMappingURL=gm.js.map