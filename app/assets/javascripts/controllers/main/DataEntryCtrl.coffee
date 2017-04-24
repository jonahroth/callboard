@Prospero.controller 'DataEntryCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.loading = true
  $scope.people_loaded = false
  $scope.works_loaded = false
  $http({
    method: 'GET',
    url: '/current_user'
  }).then((response) ->
    $scope.current_user = response.data
  )

  $scope.last_save_time = new Date()
  $scope.touch_last_saved = () -> $scope.last_save_time = new Date()
  $scope.last_saved = () ->
    str = $scope.last_save_time.toLocaleTimeString('en-US', {hour: '2-digit', minute: '2-digit', second: '2-digit'})

  days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
  human_date = (c) -> c.toDateString().substring(0, 10)
  human_time = (c) -> c.toLocaleTimeString('en-US', {hour12: true, hour: '2-digit', minute: '2-digit'})

  $scope.get_work = (id) ->
    $scope.works.filter((o) -> o.id == id)[0]

  $scope.conflict_to_string = (c) ->
    conflict_start = new Date(c.start)
    conflict_end = new Date(c.end)
    if c.frequency == 'W'
      day = days[conflict_start.getDay()]
      return "Every " + day + ": " + human_time(conflict_start) + " - " + human_time(conflict_end)
    else if human_date(conflict_start) == human_date(conflict_end)
      return human_date(conflict_start) + ": " + human_time(conflict_start) + " - " + human_time(conflict_end)
    else
      return human_date(conflict_start) + ": " + human_time(conflict_start) + " - " + human_date(conflict_end) + ": " + human_time(conflict_end)

  $scope.generate_schedule = () ->
    window.location.href = '/#/schedule'

  $scope.getWorkType = (wt) ->
    if wt.nil?
      return ""
    else return "(" + wt + ")"

  ### PEOPLE AND CONFLICTS ###
  $scope.people_message = {person: {}}
  $scope.people_success = (response) ->
    $scope.people.push(response.data)
    $scope.people_message = {person: {}}
    $('#person-form-start').focus()
    $scope.touch_last_saved()
  $scope.people_failure = (response) ->
    console.log('request failed')
  $scope.people_submit = () ->
    $http({
      method: 'POST',
      url: '/people.json',
      data: $scope.people_message
    }).then($scope.people_success, $scope.people_failure)
  $scope.people_delete = (id) ->
    delete_person = confirm('Are you sure you want to delete this person?')
    if delete_person
      $http({
        method: 'DELETE',
        url: '/people/' + id + '.json'
      }).then((() ->
        $scope.people = $scope.people.filter((o) -> o.id != id)
        $scope.people_names = $scope.people.map (obj) ->
          obj.first + " " + obj.last
        $scope.touch_last_saved()
      ), $scope.people_failure)

  should_add_conflict = (person_id) ->
    $scope.conflicts_messages[person_id] != {}

  $scope.conflicts_success = (response) ->
    person = $scope.people.filter((o) -> o.id == response.data.id)[0]
    person.conflicts.push(response.data.conflicts[response.data.conflicts.length - 1])
  $scope.touch_last_saved()
  $scope.conflicts_failure = (response) ->
    person = $scope.people.filter((o) -> o.id == response.config.data.person.id)[0]
    for str in response.data['conflicts.base']
      conflict_id = parseInt(str.match(/Identical Conflict: (\d+)/)[1])
      dom_conflict = $('#conflict_' + conflict_id)
      dom_conflict.addClass('flash-green')
      window.setTimeout((() -> dom_conflict.removeClass('flash-green')), 1000)


  dp = (id) ->
    $('#conflictInput_' + id + ' .time').timepicker({
      'showDuration': true,
      'timeFormat': 'h:mm p'
    })
    $('#conflictInput_' + id + ' .date').datepicker({
      'format': 'm/d/yyyy',
      'autoclose': true
    })
    e = document.getElementById('conflictInput_' + id)
    new Datepair(e) if e isnt null

  $scope.conflicts_submit = (id) ->
    if should_add_conflict(id)
      console.log(conflict_data = $scope.conflicts_messages[id])
      $http({
        method: 'PUT',
        url: '/people/' + id + '.json',
        data: {
          person: {
            id: id, conflicts_attributes: [{
              'start': new Date(conflict_data.start_date + " " + conflict_data.start_time),
              'end': new Date(conflict_data.end_date + " " + conflict_data.end_time),
              'frequency': conflict_data.frequency
            }]
          }
        }
      }).then($scope.conflicts_success, $scope.conflicts_failure)
    else
      console.log('attempted to add empty conflict')

  $scope.conflicts_delete = (person_id, conflict_id) ->
    $http({
      method: 'PUT',
      url: '/people/' + person_id + '.json',
      data: {
        person: {
          id: person_id, conflicts_attributes: [{
            id: conflict_id,
            _destroy: true
          }]
        }
      }
    }).then((() ->
      person = $scope.people.filter((o) -> o.id == person_id)[0]
      person.conflicts = person.conflicts.filter((o) -> o.id != conflict_id)
      $scope.touch_last_saved()
    ), $scope.conflicts_failure)


  people_load_success_fn = (response) ->
    $scope.people = (response.data)
    $scope.people_names = $scope.people.map (obj) ->
      obj.first + " " + obj.last
    $scope.conflicts_messages = {}
    offset = new Date().getTimezoneOffset()
    $scope.conflicts_messages[p.id] = {frequency: 'O', offset: (offset / 60)} for p in $scope.people

    dp(p.id) for p in $scope.people

    $scope.people_loaded = true
    $scope.loading = false if $scope.works_loaded

  people_load_failure_fn = (response) -> console.log(response.status)

  $http({method: 'GET', url: '/people.json'})
    .then(people_load_success_fn, people_load_failure_fn)

  ### WORK AND PERSONWORK ###

  $scope.works_message = {work: {}}
  $scope.works_success = (response) ->
    $scope.works.push(response.data)
    $scope.works_message = {work: {}}
    $scope.touch_last_saved()
    $('#work-form-start').focus()
  $scope.works_failure = (response) ->
    console.log('request failed')
  $scope.works_submit = () ->
    $http({
      method: 'POST',
      url: '/works.json',
      data: $scope.works_message
    }).then($scope.works_success, $scope.works_failure)
  $scope.works_delete = (id) ->
    delete_work = confirm('Are you sure you want to delete this work?')
    if delete_work
      $http({
        method: 'DELETE',
        url: '/works/' + id + '.json'
      }).then((() ->
        $scope.works = $scope.works.filter((o) -> o.id != id)
        $scope.touch_last_saved()
      ), $scope.people_failure)

  works_load_success_fn = (response) ->
    $scope.works = (response.data)
    console.log $scope.works
    $scope.person_works_messages = {}
    $scope.person_works_success = (response) ->
      work = $scope.works.filter((o) -> o.id == response.data.id)[0]
      work.called.push(response.data.called[response.data.called.length - 1])
      $scope.touch_last_saved()
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
          data: {work: {id: id, person_works_attributes: [{person_id: person_id}]}}
        }).then($scope.person_works_success, $scope.person_works_failure)
        $scope.person_works_messages[id] = null
      else
        console.log('attempted to add already called person')
    $scope.person_works_delete = (work_id, pwork_id) ->
      $http({
        method: 'PUT',
        url: '/works/' + work_id + '.json',
        data: {work: {id: work_id, person_works_attributes: [{id: pwork_id, _destroy: true}]}}
      }).then((() ->
        work = $scope.works.filter((o) -> o.id == work_id)[0]
        work.called = work.called.filter((o) -> o.call_id != pwork_id)
        $scope.touch_last_saved()
      ), $scope.person_works_failure)


    $scope.dependency_messages = {}
    $scope.dependency_success = (response) ->
      work = $scope.get_work(response.data.id)
      work.dependencies.push(response.data.dependencies[response.data.dependencies.length - 1])
    $scope.dependency_failure = (response) ->
      console.log(response)
    should_add_dependency = (work_id, dependency_id) ->
      return false unless work_id && dependency_id
      return false if work_id == dependency_id
      current_work = $scope.get_work(work_id)
      dependent_work = $scope.get_work(dependency_id)
      return false if dependent_work.dependencies.map((o) -> o.dependency_id).includes(work_id)
      return true

    $scope.dependency_submit = (id) ->
      dependency_id = parseInt($scope.dependency_messages[id])
      if should_add_dependency(id, dependency_id)
        $http({
          method: 'PUT',
          url: '/works/' + id + '.json',
          data: {work: {id: id, dependencies_attributes: [{dependency_id: dependency_id}]}}
        }).then($scope.dependency_success, $scope.dependency_failure)
        $scope.dependency_messages[id] = null

    $scope.dependency_delete = (work_id, wd_id) ->
      $http({
        method: 'PUT',
        url: '/works/' + work_id + '.json',
        data: {work: {id: work_id, dependencies_attributes: [{id: wd_id, _destroy: true}]}}
      }).then((() ->
        work = $scope.get_work(work_id)
        work.dependencies = work.dependencies.filter((o) -> o.id != wd_id)
      ), $scope.dependency_failure)
    $scope.works_loaded = true
    $scope.loading = false if $scope.people_loaded


  works_load_failure_fn = (response) -> console.log(response.status)
  $http({method: 'GET', url: '/works.json'})
    .then(works_load_success_fn, works_load_failure_fn)

]