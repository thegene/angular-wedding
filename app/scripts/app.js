'use strict';

/**
 * @ngdoc overview
 * @name angularWeddingApp
 * @description
 * # angularWeddingApp
 *
 * Main module of the application.
 */
angular
  .module('angularWeddingApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ui.bootstrap',
    'weddingFilters',
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
