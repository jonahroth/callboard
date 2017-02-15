class CrewCall < ApplicationRecord
  belongs_to :crew_role
  belongs_to :rehearsal
end
