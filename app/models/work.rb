class Work < ApplicationRecord
  has_many :person_works
  has_many :people, through: :person_works
  belongs_to :rehearsal, optional: true
  belongs_to :production

  accepts_nested_attributes_for :person_works

  # validate do
  #   if rehearsal && rehearsal.production != production
  #     errors.add(:rehearsal, 'Rehearsal must be part of the production')
  #   end
  # end

  def called
    people
  end
end
