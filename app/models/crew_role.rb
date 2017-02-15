class CrewRole < ApplicationRecord
  belongs_to :person
  belongs_to :department
end
