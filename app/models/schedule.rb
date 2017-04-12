class Schedule < ApplicationRecord
  belongs_to :production
  has_many :rehearsals
end
