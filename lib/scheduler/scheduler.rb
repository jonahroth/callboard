module Scheduler

  # TODO pass in a hash, not an array of preferences
  def Scheduler.schedule(schedule, max_duration = 4.hours,
                         max_mins_between_breaks = 55, break_len = 5,
                         time_constraints = TimeConstraints.new)
    works = schedule.production.works
    rehearsals = []
    while not works.empty?
      current_rehearsal = Rehearsal.new(start_time: DateTime.now)
      current_works = [works.shift]
      while true
        sim = works.max_by { |w| w.similarity(current_works[-1]) }
        if current_works.map { |w| w.duration }.reduce(:+) + sim.duration > max_duration / 60
          current_rehearsal.works = current_works
          current_rehearsal.resequence_all_work
          rehearsals << current_rehearsal
          break
        end
        current_works << sim
        works.delete(sim)
      end
    end
    schedule.rehearsals = [Rehearsal.new]
    schedule
  end

end

