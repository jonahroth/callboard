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

  def conflicts
    conflicts = Set.new
    works.each do |w| 
      conflicts = conflicts | w.conflicts(w.start_time)
    end
    conflicts
  end

  def dead_time
    total = 0
    processed = Set.new
    works.each do |w|
      w.called.each do |p|
        if processed.include?(p)
          next
        end
        processed << p
        total += person_dead_time(p)
      end
    end
    total
  end

  # def dad_time
  #   true
  # end
  
  def person_dead_time(p)
    dead = []
    first_index = nil
    last_index = nil
    works.each_with_index do |w, i|
      if w.called.include?(p)
        first_index = first_index.nil? ? i : first_index
        last_index = i
        dead << 0
      else
        dead << w.duration
      end 
    end
    first_index.nil? ? 0 : dead[first_index..last_index].reduce(0, :+)
  end
  
end
