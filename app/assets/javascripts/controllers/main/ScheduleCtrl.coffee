@Prospero.controller 'ScheduleCtrl', ($scope, $http) ->
  schedule_success = (response) ->
    $scope.schedule = response.data
    console.log($scope.schedule)

  $scope.date_format = (date) ->
    new Date(date).toDateString()

  $scope.swappable = (work1, work2) ->
    true

  $scope.on_drop = (event) ->


  $scope.swap = (id1, id2) ->
    rehearsal1 = null
    rehearsal2 = null
    for rehearsal in $scope.schedule.rehearsals
      rehearsal1 = rehearsal if work1 in rehearsal.works
      rehearsal2 = rehearsal if work2 in rehearsal.works
    index1 = rehearsal1.works.indexOf(work1)
    index2 = rehearsal2.works.indexOf(work2)
    tmp = work1
    rehearsal1.works[index1] = work2
    rehearsal2.works[index2] = work1

  $scope.all_swappable = (work1) ->
    swappable_works = []
    for rehearsal in $scope.schedule.rehearsals
      for work in rehearsal.works
        if $scope.swappable(work1, work)
          swappable_works.push work.id
    swappable_works

  $scope.highlight_all_swappable = (event) ->
    console.log orig_work
    for rehearsal in $scope.schedule.rehearsals
      for work in rehearsal.works
        if work.id in $scope.all_swappable(orig_work)
          work.swappable = true
    $scope.$digest()

  $scope.unhighlight_all_swappable = (event) ->
    for rehearsal in $scope.schedule.rehearsals
      for work in rehearsal.works
        work.swappable = false
    $scope.$digest()



  $http({method: 'GET', url: '/generate.json'})
    .then(schedule_success)