class PersonWork < ApplicationRecord
  belongs_to :person
  belongs_to :work
end
