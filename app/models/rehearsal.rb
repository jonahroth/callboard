class Rehearsal < ApplicationRecord
  has_many :rehearsal_scenes
  has_many :notes

  def people_called
    rehearsal_scenes.map(&:scene).map(&:people).flatten.uniq
  end
end
