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
  $scope.last_save_time = new Date()
  $scope.touch_last_saved = () -> $scope.last_save_time = new Date()
  $scope.last_saved = () -> $scope.last_save_time.toUTCString()

  $scope.people_message = {person: {}}
  $scope.people_success = (response) ->
    $scope.people.push(response.data)
    $scope.people_message = {person: {}}
  $scope.people_failure = (response) ->
    $scope.people.push({first: 'fail'})
  $scope.people_submit = () ->
    console.log($scope.people_message)
    $http({
      method: 'POST',
      url: '/people.json',
      data: $scope.people_message,
      format: 'application/json'
    }).then($scope.people_success, $scope.people_failure)

  $scope.works_message = {work: {}}
  $scope.works_success = (response) ->
    $scope.works.push(response.data)
    $scope.works_message = {work: {}}
  $scope.works_failure = (response) ->
    $scope.works.push({name: 'fail'})
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

  works_load_success_fn = (response) ->
    $scope.works = (response.data)
  works_load_failure_fn = (response) -> console.log(response.status)
  $http({method: 'GET', url: '/works.json'})
    .then(works_load_success_fn, works_load_failure_fn)

  $scope.person_works_messages = {}
  $scope.person_works_success = (response) ->
    work = $scope.works.filter((o) -> o.id == response.data.id)[0]
    work.called.push(response.data.called[response.data.called.length - 1])
  $scope.person_works_failure = (response) ->
    console.log('request failed')
  should_add_person_work = (work_id, person_id) ->
    current_work = $scope.works.filter((o) -> o.id == work_id)[0]
    $scope.person_works_messages[work_id] and current_work and !current_work.called.filter((o) -> o.id == person_id)[0]

  $scope.person_works_submit = (id) ->
    person_id = parseInt($scope.person_works_messages[id])
    if (should_add_person_work(id, person_id))
      $http({
        method: 'PUT',
        url: '/works/' + id + '.json'
        data: {work: {id: id, person_works_attributes: [{person_id: person_id}]}},
        format: 'application/json'
      }).then($scope.person_works_success, $scope.person_works_failure)
      $scope.person_works_messages[id] = null
    else
      console.log('attempted to add already called person')

Prospero.controller 'DifCtrl', ($scope) ->
  $scope.title = "Different controller..."