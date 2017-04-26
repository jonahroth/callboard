module Scheduler

  # TODO pass in a hash, not an array of preferences
  def Scheduler.schedule(production, start_day = Date.today,
                         end_day = Date.today + 1.month,
                         max_duration = 4.hours, 
                         max_mins_between_breaks = 55,
                         break_len = 5)
    # delete all schedules associated with production
    production.schedules do |s|
      s.delete!
    end
    schedule = Schedule.create!(production: production)
    cpr = 3 # calls per rehearsal - just some temporary nonsense
    rehearsals = set_rehearsals.map do |e|
      e.dup
    end
    start = Time.now
    new_rehearsal = Rehearsal.create!(start_time: start, schedule: schedule)
    production.works.each_with_index do |c, i|
      c.break_duration = 5
      c.sequence_id = i + 1
      new_rehearsal.works << c
      if new_rehearsal.works.length >= cpr
        new_rehearsal.works[-1].break_duration = 0
        rehearsals << new_rehearsal
        start = start.dup + (1.day) # +1 day
        new_rehearsal = Rehearsal.create!(start_time: start, schedule: schedule)
     end
      c.save!
      new_rehearsal.save!
    end
    unless rehearsals.include?(new_rehearsal) or new_rehearsal.works.empty?
      new_rehearsal.works[-1].break_duration = 0
      rehearsals << new_rehearsal
      new_rehearsal.save!
    end
    schedule.save!
    production.save!
    schedule
  end

end

