class Conflict < ApplicationRecord
  belongs_to :person

  ONCE = 'O'
  WEEKLY = 'W'

  validates :frequency, :start, :end, presence: true
  validates :frequency, inclusion: [ONCE, WEEKLY]
  validate :start_not_past, :end_after_start, :no_repeat

  def start=(str)
    super(DateTime.parse(str))
  end

  def end=(str)
    super(DateTime.parse(str))
  end

  def once?
    frequency == ONCE
  end

  def weekly?
    frequency == WEEKLY
  end

  def start_not_past
  	errors.add(:start, "Cannot be in the past") if 
  	  start < Date.today
  end

  def end_after_start
  	errors.add(:end, "Cannot occur before start") if 
  	  self.end < start	
  end

  def no_repeat
  	Conflict.where(person_id: self.person_id).each do |c|
  		errors.add("Identical Conflict") if 
  			c.start == self.start && c.end == self.end && c.frequency == self.frequency
  	end
  end

end
