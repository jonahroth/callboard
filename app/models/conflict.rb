class Conflict < ApplicationRecord
  belongs_to :person

  validates :frequency, presence: true
  validates :frequency, inclusion: %w( O W )

  ONCE = 'O'
  WEEKLY = 'W'

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
