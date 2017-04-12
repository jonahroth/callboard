json.extract! schedule, :id, :created_at, :updated_at
json.url schedule_url(schedule, format: :json)
json.rehearsals schedule.rehearsals do |rehearsal|
  json.partial! rehearsal
end