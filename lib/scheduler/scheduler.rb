module Scheduler

  # TODO pass in a hash, not an array of preferences
  def Scheduler.schedule( calls, set_rehearsals=[], preferences=[] )
    cpr = 3 # calls per rehearsal - just some temporary nonsense
    rehearsals = set_rehearsals.map do |e| e.dup end
    start = Time.now
    new_rehearsal = Rehearsal.create(created_at: start, updated_at: start)
    calls.each do |c|
      c.break_duration = 5
      new_rehearsal.schedule << c
      if new_rehearsal.schedule.length >= cpr
        new_rehearsal.schedule[-1].break_duration = 0
        rehearsals << new_rehearsal
        start = start.dup + (60*60*24) # +1 day
        new_rehearsal = Rehearsal.create(created_at: start,
                                         updated_at: start)
      end
      c.save
      new_rehearsal.save
    end
    if not rehearsals.include?(new_rehearsal)
      new_rehearsal.schedule[-1].break_duration = 0
      rehearsals << new_rehearsal
      new_rehearsal.save
    end
    rehearsals
  end

  # Whether this piece of work can be scheduled at a given start time
  # without conflicts. Perhaps this should be updated later to return a
  # number, rather than a boolean, in order to express call priority.
  def fits( work, start_datetime )
    all_conflicts(work, start_datetime).size == 0
  end

  def all_conflicts( work, start_datetime )
    end_time = start_time + work.duration.minutes
    conflicts = Set.new
    work.called.each do |p|
      p.conflicts.each do |c|
        # add c to the set if it conflicts with the time
      end
    end
    conflicts
  end

  private :fits :all_conflicts
end

