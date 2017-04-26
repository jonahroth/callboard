class SchedulesController < ApplicationController
  include Scheduler
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  def index
    @schedules = Schedule.all
  end

  def show
  end

  def new
    @schedule = Schedule.new
  end

  def edit
  end

  def create
    schedule_params[:start_date] = DateTime.strptime(schedule_params[:start_date], "%m/%d/%Y")
    schedule_params[:end_date] = DateTime.strptime(schedule_params[:end_date], "%m/%d/%Y")
    @schedule = Schedule.new(schedule_params)
    @schedule.production = current_production

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def generate
    if current_production.schedules.any?
      @schedule = current_production.schedules.last
      Scheduler.schedule(@schedule) unless @schedule.rehearsals.any?
      @schedule.production = current_production
      @schedule.save!
      render :show, location: @schedule, status: :created, format: :json
    else
      new_schedule = current_production.schedules.new
      @schedule = Scheduler.schedule(new_schedule)
      render :show, location: @schedule, status: :created, format: :json
    end
  end

  def distribute
    emails = current_production.people.map(&:email).select { |str| is_email(str) }
    puts emails
    emails.each { |e| ScheduleMailer.schedule_email(e, current_production.schedules.last).deliver_now }
    head :success
  end

  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:id, :production_id, :start_date, :end_date,
                                     rehearsals: [:title, :start_time, :production_id, :schedule_id,
                                                  works: [:name, :work_type, :duration, :break_duration,
                                                          :rehearsal_id, :production_id, :swappable]])
  end

  def is_email(str)
    str =~ VALID_EMAIL_REGEX
  end
end
