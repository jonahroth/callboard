class ScheduleMailer < ApplicationMailer
  default from: 'schedules@example.com'

  def schedule_email(email, schedule)
    @schedule = schedule
    mail(to: email, subject: "#{schedule.production.title} Rehearsal Schedule #{Date.today.to_s}")
  end
end
