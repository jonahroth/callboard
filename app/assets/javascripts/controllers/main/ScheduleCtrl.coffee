@Prospero.controller 'ScheduleCtrl', ($scope, $http) ->
  schedule_success = (response) ->
    $scope.schedule = response.data
    console.log($scope.schedule)

  $scope.date_format = (date) ->
    new Date(date).toDateString()

  $scope.swappable = (work1, work2) ->
    true

  $scope.on_drop = (work, args) ->
    console.log work
    console.log args

  $scope.swap = (work1, work2) ->
    tmp = work1
    work1 = work2
    work2 = tmp

  $scope.all_swappable = (work1) ->
    swappable_works = []
    for rehearsal in $scope.schedule.rehearsals
      for work in rehearsal.works
        if $scope.swappable(work1, work)
          swappable_works << work.id
    swappable_works

  $scope.highlight_all_swappable = (work) ->
    console.log("I was fired!")
    for rehearsal in $scope.schedule.rehearsals
      for work in rehearsal.works
        work.swappable = true
        console.log work.id + " " + work.swappable
    $scope.$digest()

  $scope.unhighlight_all_swappable = (work) ->
    console.log("I was fired too!")
    for rehearsal in $scope.schedule.rehearsals
      for work in rehearsal.works
        work.swappable = false
        console.log work.id + " " + work.swappable
    $scope.$digest()



  $http({method: 'GET', url: '/generate.json'})
    .then(schedule_success)