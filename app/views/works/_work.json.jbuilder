json.extract! work, :id, :name, :work_type, :duration, :break_duration, :rehearsal_id, :sequence_id, :created_at, :updated_at
json.url work_url(work, format: :json)
json.start_time work.start_time
json.called work.person_works do |pw|
  json.first pw.person.first
  json.last pw.person.last
  json.id pw.person.id
  json.call_id pw.id
end
json.dependencies work.dependencies do |d|
  json.id d.id
  json.dependent_id d.dependent_id
  json.dependency_id d.dependency_id
end