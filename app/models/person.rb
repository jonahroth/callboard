class Person < ApplicationRecord
  has_one :user
  # NOTE: optional true because of onboarding process
  belongs_to :production, optional: true
  has_many :characters
  has_many :crew_roles
  has_many :conflicts, dependent: :delete_all
  has_many :person_works, dependent: :delete_all
  has_many :works, through: :person_works

  accepts_nested_attributes_for :conflicts, allow_destroy: true

  def is_cast?
    characters.any?
  end

  def is_crew?
    crew_roles.any?
  end

  def link_to_uuid(uuid)
    self.ios_uuid = uuid
    self.save!
  end
end
