class Work < ApplicationRecord
  has_many :person_works
  has_many :people, through: :person_works
  belongs_to :rehearsal, optional: true
  belongs_to :production

  accepts_nested_attributes_for :person_works

  # validate do
  #   if rehearsal && rehearsal.production != production
  #     errors.add(:rehearsal, 'Rehearsal must be part of the production')
  #   end
  # end

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
    end_time = start_time + self.duration.minutes
    conflicts = Set.new
    work.called.each do |p|
      p.conflicts.each do |c|
        # add c to the set if it conflicts with the time
      end
    end
    conflicts
  end
end
