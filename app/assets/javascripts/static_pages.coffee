# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require_self
#= require_tree ./services/global
#= require_tree ./services/main
#= require_tree ./filters/global
#= require_tree ./filters/main
#= require_tree ./controllers/global
#= require_tree ./controllers/main
#= require_tree ./directives/global
#= require_tree ./directives/main

Prospero = angular.module("prospero", ["ngRoute", "templates"])

Prospero.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/dif', {templateUrl: 'different.html', controller: 'DifCtrl'})
  $routeProvider.otherwise({templateUrl: 'mainPost.html', controller: 'IndexCtrl'})
])

Prospero.config(['$locationProvider', ($locationProvider) ->
  $locationProvider.hashPrefix('');
])

Prospero.controller 'IndexCtrl', ($scope) ->
  $scope.title = "My Prospero!"
  $scope.contents = "Sweet dreams are made of this"

Prospero.controller 'DifCtrl', ($scope) ->
  $scope.title = "Different controller..."