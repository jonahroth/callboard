class Work < ApplicationRecord
  has_many :person_works, dependent: :delete_all
  has_many :people, through: :person_works
  has_many :dependencies, class_name: 'WorkDependency', foreign_key: :dependent_id, dependent: :delete_all
  has_many :dependents, class_name: 'WorkDependency', foreign_key: :dependency_id, dependent: :delete_all
  belongs_to :rehearsal, optional: true
  belongs_to :production

  accepts_nested_attributes_for :person_works, allow_destroy: true
  accepts_nested_attributes_for :dependencies, allow_destroy: true

  def called
    people
  end

  def start_time
    return nil unless rehearsal
    time = rehearsal.start_time
    rehearsal_works = rehearsal.works.order(:sequence_id)

    for w in rehearsal_works do
      break if w.id == self.id
      time += w.duration.minutes
      time += w.break_duration.minutes
    end
    time
  end

  # Whether this piece of work can be scheduled at a given start time
  # without conflicts.
  # TODO Allow for expressing priority, maybe by returning a number instead
  # of a simple boolean.
  def fits?(start_datetime)
    conflicts.size == 0
  end

  def conflicts(start_datetime)
    end_datetime = start_time + self.duration.minutes
    conflicts = Set.new
    work.called.each do |p|
      p.conflicts.each do |c|
        unless c.fits?(start_datetime, end_datetime)
          conflicts << c
        end
      end
    end
    conflicts
  end

  def similarity(other_work)
    my_called = called.to_set
    other_called = other_work.called.to_set
    if my_called.subset?(other_called) or other_called.subset?(my_called)
      1.0
    else
      (my_called & other_called).size.to_f / (my_called | other_called).size
    end
  end

end
