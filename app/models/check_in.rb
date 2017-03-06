class CheckIn < ApplicationRecord
  belongs_to :person
  belongs_to :rehearsal
end
