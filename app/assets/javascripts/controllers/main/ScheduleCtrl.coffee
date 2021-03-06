@Prospero.controller 'ScheduleCtrl', ($scope, $http) ->
  $scope.loading = false
  schedule_success = (response) ->
    $scope.schedule = response.data
    $scope.loading = false
    console.log($scope.schedule)

  $scope.dragged_work = null
  $scope.dropped_work = null

  $scope.recalculate_all_times = () ->
    for rehearsal in $scope.schedule.rehearsals
      time = new Date(rehearsal.start_time)
      for work in rehearsal.works
        work.start_time = time
        time = new Date(time.getTime() + ((work.duration + work.break_duration) * 60000))

  $scope.date_format = (date) ->
    new Date(date).toDateString()

  $scope.time_format = (date) ->
    new Date(date).toLocaleTimeString('en-US', {hour12: true, hour: '2-digit', minute: '2-digit'})

  $scope.swappable = (work1, work2) ->
    true

  $scope.on_work_drag = (event) ->
    $scope.dragged_work = $scope.get_dragged_work(event)
    $scope.highlight_all_swappable($scope.dragged_work)
    $scope.$digest()

  $scope.on_work_drag_end = (event) ->
    $scope.unhighlight_all_swappable()
    $scope.reset_drag_position(event.target)
    $scope.$digest()

  $scope.on_drop = (event) ->
    work = $scope.get_dropped_work(event)
    $scope.dropped_work = $scope.get_dropped_work(event)
    $scope.swap($scope.dragged_work, $scope.dropped_work)
    $scope.update_work($scope.dragged_work, $scope.dropped_work)
    $scope.recalculate_all_times()

  $scope.swap = (work1, work2) ->
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
    tmp = work1.start_time

  $scope.all_swappable = (work1) ->
    swappable_works = []
    for rehearsal in $scope.schedule.rehearsals
      for work in rehearsal.works
        if $scope.swappable(work1, work)
          swappable_works.push work.id
    swappable_works

  $scope.highlight_all_swappable = (orig_work) ->
    for rehearsal in $scope.schedule.rehearsals
      for work in rehearsal.works
        if work.id in $scope.all_swappable(orig_work)
          work.swappable = true

  $scope.unhighlight_all_swappable = () ->
    for rehearsal in $scope.schedule.rehearsals
      for work in rehearsal.works
        work.swappable = false

  $scope.reset_drag_position = (target) ->
    target.style.removeProperty('top')
    target.style.removeProperty('left')

  $scope.get_dragged_work = (event) ->
    id = parseInt(event.target.id.match(/\d+/))
    $scope.get_work(id)

  $scope.get_dropped_work = (event) ->
    id = parseInt(event.target.id.match(/\d+/))
    $scope.get_work(id)

  $scope.get_work = (id) ->
    for rehearsal in $scope.schedule.rehearsals
      for work in rehearsal.works
        return work if work.id == id
    null

  $scope.update_work = (work, other_work) ->
    console.log work.id + " " + work.sequence_id + " " + work.rehearsal_id
    console.log other_work.id + " " + other_work.sequence_id + " " + other_work.rehearsal_id
    tmp = {rehearsal_id: $scope.dragged_work.rehearsal_id, sequence_id: $scope.dragged_work.sequence_id}
    $scope.dragged_work.sequence_id = $scope.dropped_work.sequence_id
    $scope.dragged_work.rehearsal_id = $scope.dropped_work.rehearsal_id
    $scope.dropped_work.sequence_id = tmp.sequence_id
    $scope.dropped_work.rehearsal_id = tmp.rehearsal_id
    console.log work.id + " " + work.sequence_id + " " + work.rehearsal_id
    console.log other_work.id + " " + other_work.sequence_id + " " + other_work.rehearsal_id

  $scope.distribute = () ->
    $http({
      method: 'GET',
      url: '/distribute.json'
    }).then((response) ->
      console.log response
    )

    $http({
      method: 'PUT',
      url: '/works/' + work.id + '.json',
      data: {work: {sequence_id: work.sequence_id, rehearsal_id: work.rehearsal_id}}
    }).then(() ->
      $http({
        method: 'PUT',
        url: '/works/' + other_work.id + '.json',
        data: {work: {sequence_id: other_work.sequence_id, rehearsal_id: other_work.rehearsal_id}}
      })
    )

  $http({method: 'GET', url: '/generate.json'})
    .then(schedule_success)