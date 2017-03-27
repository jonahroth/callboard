class Work < ApplicationRecord
  has_many :person_works
  has_many :people, through: :person_works

  accepts_nested_attributes_for :person_works

  def called
    people
  end
end
