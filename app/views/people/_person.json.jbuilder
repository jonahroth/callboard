json.extract! person, :id, :first, :last, :created_at, :updated_at
json.url person_url(person, format: :json)