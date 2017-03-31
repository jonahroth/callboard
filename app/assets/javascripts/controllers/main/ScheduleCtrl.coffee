@Prospero.controller 'ScheduleCtrl', ($scope, $http) ->
  schedule_success = (response) ->
    $scope.schedule = response.data
    console.log($scope.schedule)
  $http({method: 'GET', url: '/generate.json'})
    .then(schedule_success)