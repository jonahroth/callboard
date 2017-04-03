class Conflict < ApplicationRecord
  belongs_to :person

  validates :frequency, presence: true
  validates :frequency, inclusion: %w( O W )

  attr_accessor :start_time, :end_time, :start_date, :end_date

  ONCE = 'O'
  WEEKLY = 'W'

  def start_time=(str)
    @start_time = str
    compile_start
  end

  def start_date=(str)
    @start_date = str
    compile_start
  end

  def end_time=(str)
    @end_time = str
    compile_end
  end

  def end_date=(str)
    @end_date = str
    compile_end
  end

  def once?
    frequency == ONCE
  end

  def weekly?
    frequency == WEEKLY
  end

  private

  def compile_start
    if @start_time && @start_date
      day, month, year = @start_date.match(/(\d*)\/(\d*)\/(\d*)/).captures.map(&:to_i)
      hour, minute = @start_time.match(/(\d*):(\d*)/).captures.map(&:to_i)
      self.start = DateTime.new(year, month, day, hour, minute, 0, )
      # self.save!
    end
  end

  def compile_end
    if @end_time && @end_date
      day, month, year = @end_date.match(/(\d*)\/(\d*)\/(\d*)/).captures.map(&:to_i)
      hour, minute = @end_time.match(/(\d*):(\d*)/).captures.map(&:to_i)
      self.end = DateTime.new(year, month, day, hour, minute)
      # self.save!
    end
  end
end
