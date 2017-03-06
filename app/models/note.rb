class Note < ApplicationRecord
  belongs_to :rehearsal
  has_many :department_notes
end
