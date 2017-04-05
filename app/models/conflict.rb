class Conflict < ApplicationRecord
  belongs_to :person

  ONCE = 'O'
  WEEKLY = 'W'

  validates :frequency, presence: true
  validates :frequency, inclusion: [ONCE, WEEKLY]

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
end
