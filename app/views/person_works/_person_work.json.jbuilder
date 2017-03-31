json.extract! person_work, :id, :person_id, :work_id, :created_at, :updated_at
json.url person_work_url(person_work, format: :json)