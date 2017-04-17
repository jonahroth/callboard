json.extract! rehearsal, :id, :title, :start_time, :created_at, :updated_at
json.url rehearsal_url(rehearsal, format: :json)
json.works rehearsal.works do |work|
  json.partial! work
end