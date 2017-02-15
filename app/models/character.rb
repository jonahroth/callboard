class Character < ApplicationRecord
  belongs_to :person
  has_many :character_scenes

  def scenes
    character_scenes.map(&:scene)
  end
end
