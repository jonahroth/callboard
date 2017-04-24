json.extract! person, :id, :first, :last, :email, :cell, :created_at, :updated_at
json.url person_url(person, format: :json)
json.conflicts person.conflicts, :id, :start, :end, :frequency