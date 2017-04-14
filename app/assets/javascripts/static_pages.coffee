#= require_self
#= require autocomplete
#= require moment
#= require xeditable
#= require_tree ./controllers/main

@Prospero = angular.module("prospero", ["ngRoute", "templates", "autocomplete", "ngDragDrop"])

@Prospero.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/schedule', {templateUrl: 'schedule.html', controller: 'ScheduleCtrl'})
  $routeProvider.otherwise({templateUrl: 'data_entry.html', controller: 'DataEntryCtrl'})
])

@Prospero.config(['$locationProvider', ($locationProvider) ->
  $locationProvider.hashPrefix('')
])

@Prospero.config(['$compileProvider', ($compileProvider) ->
  $compileProvider.debugInfoEnabled(true)
])


# http://stackoverflow.com/questions/22486264/angular-and-datepair-wont-play-nice
@Prospero.directive('timePicker', ['$timeout', ($timeout) ->
  return {
    restrict: 'AC',
    scope: {
      ngModel: '='
    },
    link: (scope, element) ->
      element.on('change', () ->
        if (element.hasClass('start'))
          $timeout((() ->
            $el = element.closest('[date-pair]').find('input.end')
            endScope = angular.element($el).isolateScope()

            endScope.$apply(() ->
              endScope.ngModel = $el.val();
            )
          ), 0)
      )
      element.timepicker({
        timeFormat: 'H:i',
        forceRoundTime: true
      })
  }
])

@Prospero.directive('datePicker', () ->
  return {
    restrict: 'AC',
    link: (scope, element) ->
      element.datepicker({
        format: 'm/d/yyyy',
        autoclose: true,
        todayHighlight: true
      })
  }
)

@Prospero.directive('datePair', [() ->
  return {
    restrict: 'AC',
    link: (scope, element) ->
      element.datepair()
  }
])