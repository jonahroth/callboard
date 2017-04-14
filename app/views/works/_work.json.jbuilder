json.extract! work, :id, :name, :work_type, :duration, :break_duration, :rehearsal_id, :sequence_id, :created_at, :updated_at
json.url work_url(work, format: :json)
json.called work.called do |person|
  json.first person.first
  json.last person.last
  json.id person.id
end