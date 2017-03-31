# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require_self
#= require autocomplete
#= require moment
#= require xeditable
#= require_tree ./services/global
#= require_tree ./services/main
#= require_tree ./filters/global
#= require_tree ./filters/main
#= require_tree ./controllers/global
#= require_tree ./controllers/main
#= require_tree ./directives/global
#= require_tree ./directives/main

@Prospero = angular.module("prospero", ["ngRoute", "templates", "autocomplete", "xeditable"])

@Prospero.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/schedule', {templateUrl: 'schedule.html', controller: 'ScheduleCtrl'})
  $routeProvider.otherwise({templateUrl: 'data_entry.html', controller: 'DataEntryCtrl'})
])

@Prospero.run((editableOptions) ->
  editableOptions.theme = 'bs3';
)

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

Prospero.controller 'DifCtrl', ($scope, $http) ->
  schedule_success = (response) ->
    $scope.schedule = response.data
    console.log($scope.schedule)
  $http({method: 'GET', url: '/generate.json'})
    .then(schedule_success)
