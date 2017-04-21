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

  # Whether this piece of work can be scheduled at a given start time
  # without conflicts.
  # TODO Allow for expressing priority, maybe by returning a number instead
  # of a simple boolean.
  def fits?(start_datetime)
    all_conflicts(start_datetime).size == 0
  end

  def all_conflicts(start_datetime)
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

  private :all_conflicts
end
