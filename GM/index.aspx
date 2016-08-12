<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="GM.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en-gb" ng-app="gm">
<head runat="server">
    <title>GM</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,400italic" />
    <link rel="stylesheet" href="Content/angular-material.min.css" />
    <link rel="stylesheet" href="//fonts.googleapis.com/icon?family=Material+Icons" />
    <link rel="stylesheet" href="Content/gm.css" />
</head>
<body ng-cloak ng-controller="mainController as main">
    <md-toolbar>
        <div class="md-toolbar-tools">
            <md-button class="md-icon-button" ng-click="main.ToggleMenu()" ng-hide="main.WideLayout">
                <i class="material-icons">menu</i>
            </md-button>
            <span>Good Music</span>
        </div>
    </md-toolbar>
    <section layout="row" flex>
        <md-sidenav class="md-sidenav-left" md-component-id="left" md-is-locked-open="main.WideLayout">
            <md-content layout="row" layout-align="start start" flex>
                <section layout="column" flex>
                    <md-button ng-href="#/home" class="md-primary" flex>
                        <md-icon class="material-icons">home</md-icon>
                        Home
                    </md-button>
                    <md-button ng-href="#/recommend" class="md-primary" flex ng-show="main.LoggedIn">
                        <md-icon class="material-icons">youtube_searched_for</md-icon>
                        Recommend a Song
                    </md-button>
                    <md-button class="md-primary" ng-click="main.$facebook.Login()" ng-hide="main.LoggedIn" flex>
                        <md-icon class="material-icons">person_outline</md-icon>
                        Login
                    </md-button>
                    <md-button class="md-primary" ng-click="main.$facebook.Logout()" ng-show="main.LoggedIn" flex>
                        <md-icon class="material-icons">exit_to_app</md-icon>
                        Logout
                    </md-button>
                </section>
            </md-content>
        </md-sidenav>
        <section layout="column" flex>
            <ng-view></ng-view>
        </section>
    </section>
    <script src="Scripts/angular.min.js"></script>
    <script src="Scripts/angular-route.min.js"></script>
    <script src="Scripts/angular-animate.min.js"></script>
    <script src="Scripts/angular-aria.min.js"></script>
    <script src="Scripts/angular-messages.min.js"></script>
    <script src="Scripts/angular-sanitize.min.js"></script>
    <script src="Scripts/angular-material/angular-material.min.js"></script>
    <script src="Scripts/gm/gm.min.js" id="gm-script" data-authenticated="<%= Authenticated.ToString() %>" data-id="<%= UserId %>"></script>
    <script src="https://connect.facebook.net/en_US/sdk.js"></script>
    <script src="https://www.youtube.com/iframe_api"></script>
</body>
</html>
