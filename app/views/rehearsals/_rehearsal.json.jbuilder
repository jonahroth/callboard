json.extract! rehearsal, :id, :title, :created_at, :updated_at
json.url rehearsal_url(rehearsal, format: :json)
json.schedule rehearsal.schedule do |work|
  json.name work.name
  json.work_type work.work_type
  json.duration work.duration
  json.break_duration work.break_duration
end