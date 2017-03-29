class Rehearsal < ApplicationRecord
  has_many :rehearsal_scenes
  has_many :notes
  has_many :works

  def people_called
    rehearsal_scenes.map(&:scene).map(&:people).flatten.uniq
  end

  alias schedule works
end
