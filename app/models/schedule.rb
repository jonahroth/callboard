class Schedule < ApplicationRecord
  belongs_to :production
  has_many :rehearsals

  accepts_nested_attributes_for :rehearsals
end
