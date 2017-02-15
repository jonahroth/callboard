class Person < ApplicationRecord
  has_one :user
  # NOTE: optional true because of onboarding process
  belongs_to :production, optional: true
  has_many :characters
  has_many :crew_roles
  has_many :conflicts

  def is_cast?
    characters.any?
  end

  def is_crew?
    crew_roles.any?
  end
end
