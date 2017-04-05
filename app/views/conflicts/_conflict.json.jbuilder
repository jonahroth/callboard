json.extract! conflict, :id, :person_id, :created_at, :updated_at
json.start conflict.start.in_time_zone
json.end conflict.end.in_time_zone
json.url conflict_url(conflict, format: :json)