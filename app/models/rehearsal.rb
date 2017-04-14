class Rehearsal < ApplicationRecord
  belongs_to :production, optional: true
  belongs_to :schedule
  has_many :rehearsal_scenes
  has_many :notes
  has_many :works

  accepts_nested_attributes_for :works

  def people_called
    rehearsal_scenes.map(&:scene).map(&:people).flatten.uniq
  end
end
