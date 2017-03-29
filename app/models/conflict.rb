class Conflict < ApplicationRecord
  belongs_to :person

  validates :frequency, presence: true
  validates :frequency, inclusion: %w( O W )

  ONCE = 'O'
  WEEKLY = 'W'

  def once?
    frequency == ONCE
  end

  def weekly?
    frequency == WEEKLY
  end
end
