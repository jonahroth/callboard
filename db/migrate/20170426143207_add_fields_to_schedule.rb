class AddFieldsToSchedule < ActiveRecord::Migration[5.0]
  def change
    add_column :schedules, :start_date, :datetime
    add_column :schedules, :end_date, :datetime
  end
end
