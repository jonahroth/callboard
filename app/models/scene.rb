class Scene < ApplicationRecord
  belongs_to :production
  has_many :character_scenes
  has_many :rehearsal_scenes

  def characters
    character_scenes.map(&:character)
  end

  def people
    characters.map(&:person).uniq
  end
end
