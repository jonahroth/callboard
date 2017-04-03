@Prospero.controller 'DataEntryCtrl', ($scope, $http) ->
  $scope.last_save_time = new Date()
  $scope.touch_last_saved = () -> $scope.last_save_time = new Date()
  $scope.last_saved = () -> $scope.last_save_time.toUTCString()

  days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
  human_date = (c) -> c.toDateString().substring(0,10)
  human_time = (c) -> c.toTimeString().substring(0,5)

  $scope.conflict_to_string = (c) ->
    conflict_start = new Date(c.start)
    conflict_end   = new Date(c.end)
    if c.frequency == 'W'
      day = days[conflict_start.getDay()]
      return "Every " + day + ": " + human_time(conflict_start) + " - " + human_time(conflict_end)
    else
      return human_date(conflict_start) + ": " + human_time(conflict_start) + " - " + human_time(conflict_end)

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

  localize_conflict = (conflict) ->
#    conflict.start += new Date().getTimezoneOffset()
#    conflict.end += new Date().getTimezoneOffset()
    return conflict

  people_load_success_fn = (response) ->
    $scope.people = (response.data)
    $scope.people_names = $scope.people.map (obj) ->
      obj.first + " " + obj.last
    should_add_conflict = (person_id) ->
      $scope.conflicts_messages[person_id] != {}
    $scope.conflicts_messages = {}
    offset = new Date().getTimezoneOffset()
    console.log offset
    $scope.conflicts_messages[p.id] = { frequency: 'O', offset: (offset / 60) } for p in $scope.people
    $scope.conflicts_success = (response) ->
      person = $scope.people.filter((o) -> o.id == response.data.id)[0]
      console.log response.data.conflicts
      person.conflicts.push(response.data.conflicts[response.data.conflicts.length - 1])
    $scope.conflicts_failure = (response) ->
      console.log('request failed')
    dp = (id) ->
      $('#conflictInput_' + id + ' .time').timepicker({
        'showDuration': true,
        'timeFormat': 'g:ia'
      })
      $('#conflictInput_' + id + ' .date').datepicker({
        'format': 'm/d/yyyy',
        'autoclose': true
      })
      e = document.getElementById('conflictInput_' + id)
      new Datepair(e) if e isnt null

    dp(p.id) for p in $scope.people

    $scope.conflicts_submit = (id) ->
      if should_add_conflict(id)
        conflict_data = $scope.conflicts_messages[id]
        $http({
          method: 'PUT',
          url: '/people/' + id + '.json',
          data: {person: {id: id, conflicts_attributes: [{
            'start': new Date(conflict_data.start_date + " " + conflict_data.start_time),
            'end':   new Date(conflict_data.end_date + " " + conflict_data.end_time),
            'frequency': conflict_data.frequency
          }]}}
        }).then($scope.conflicts_success, $scope.conflicts_failure)
      else
        console.log('attempted to add empty conflict')

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
        url: '/works/' + id + '.json',
        data: {work: {id: id, person_works_attributes: [{person_id: person_id}]}},
        format: 'application/json'
      }).then($scope.person_works_success, $scope.person_works_failure)
      $scope.person_works_messages[id] = null
    else
      console.log('attempted to add already called person')
