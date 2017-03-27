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
    end
    if not rehearsals.include?(new_rehearsal)
      new_rehearsal.schedule[-1].break_duration = 0
      rehearsals << new_rehearsal
    end
    rehearsals
  end
end

