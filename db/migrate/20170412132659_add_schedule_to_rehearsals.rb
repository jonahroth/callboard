class AddScheduleToRehearsals < ActiveRecord::Migration[5.0]
  def change
    add_reference :rehearsals, :schedule, foreign_key: true
  end
end
