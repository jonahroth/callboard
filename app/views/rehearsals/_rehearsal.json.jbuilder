json.extract! rehearsal, :id, :title, :start_time, :created_at, :updated_at
json.url rehearsal_url(rehearsal, format: :json)
json.works rehearsal.works do |work|
  json.id work.id
  json.name work.name
  json.work_type work.work_type
  json.duration work.duration
  json.break_duration work.break_duration
  json.swappable false
end