class Rehearsal < ApplicationRecord
  belongs_to :production, optional: true
  belongs_to :schedule
  has_many :rehearsal_scenes
  has_many :notes
  has_many :works, -> { order(:sequence_id) }

  accepts_nested_attributes_for :works

  def people_called
    rehearsal_scenes.map(&:scene).map(&:people).flatten.uniq
  end

  def resequence_all_work
    works.each_with_index do |w, i|
      w.sequence_id = i+1
      w.save
    end
  end
end
