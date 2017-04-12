class AddStartTimeToRehearsals < ActiveRecord::Migration[5.0]
  def change
    add_column :rehearsals, :start_time, :datetime
  end
end
