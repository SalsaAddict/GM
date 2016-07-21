﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="GM.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en-gb" ng-app="gm">
<head runat="server">
    <title>GM</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,400italic" />
    <link rel="stylesheet" href="Content/angular-material.min.css" />
    <link rel="stylesheet" href="//fonts.googleapis.com/icon?family=Material+Icons" />
</head>
<body ng-cloak>
    <ng-view></ng-view>
    <script src="Scripts/angular.min.js"></script>
    <script src="Scripts/angular-route.min.js"></script>
    <script src="Scripts/angular-animate.min.js"></script>
    <script src="Scripts/angular-aria.min.js"></script>
    <script src="Scripts/angular-messages.min.js"></script>
    <script src="Scripts/angular-sanitize.min.js"></script>
    <script src="Scripts/angular-material/angular-material.min.js"></script>
    <script src="Scripts/gm/gm.min.js" id="gm-script" data-authenticated="<%= Authenticated.ToString() %>" data-id="<%= UserId %>"></script>
    <script src="https://www.youtube.com/iframe_api"></script>
</body>
</html>
