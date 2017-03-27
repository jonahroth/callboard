# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require_self
#= require autocomplete
#= require_tree ./services/global
#= require_tree ./services/main
#= require_tree ./filters/global
#= require_tree ./filters/main
#= require_tree ./controllers/global
#= require_tree ./controllers/main
#= require_tree ./directives/global
#= require_tree ./directives/main

Prospero = angular.module("prospero", ["ngRoute", "templates", "autocomplete"])

Prospero.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/dif', {templateUrl: 'different.html', controller: 'DifCtrl'})
  $routeProvider.otherwise({templateUrl: 'mainPost.html', controller: 'IndexCtrl'})
])

Prospero.config(['$locationProvider', ($locationProvider) ->
  $locationProvider.hashPrefix('');
])

Prospero.controller 'IndexCtrl', ($scope, $http) ->
  $scope.people_message = { person: {} }
  $scope.people_success = (response) ->
    $scope.people.push(response.data)
    $scope.people_message = { person: {} }
  $scope.people_failure = (response) ->
    $scope.people.push({ first: 'fail' })
  $scope.people_submit = () ->
    console.log($scope.people_message)
    $http({
      method: 'POST',
      url: '/people.json',
      data: $scope.people_message,
      format: 'application/json'
    }).then($scope.people_success, $scope.people_failure)

  $scope.works_message = { work: {} }
  $scope.works_success = (response) ->
    $scope.works.push(response.data)
    $scope.works_message = { work: {} }
  $scope.works_failure = (response) ->
    $scope.works.push({ name: 'fail' })
  $scope.works_submit = () ->
    console.log($scope.works_message)
    $http({
      method: 'POST',
      url: '/works.json',
      data: $scope.works_message,
      format: 'application/json'
    }).then($scope.works_success, $scope.works_failure)


  people_load_success_fn = (response) ->
    $scope.people = (response.data)
    $scope.people_names = $scope.people.map (obj) ->
      obj.first + " " + obj.last
  people_load_failure_fn = (response) -> console.log(response.status)

  $http({method: 'GET', url: '/people.json'})
    .then(people_load_success_fn, people_load_failure_fn)

  works_load_success_fn = (response) -> $scope.works = (response.data)
  works_load_failure_fn = (response) -> console.log(response.status)
  $http({method: 'GET', url: '/works.json'})
    .then(works_load_success_fn, works_load_failure_fn)


Prospero.controller 'DifCtrl', ($scope) ->
  $scope.title = "Different controller..."