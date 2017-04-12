class AddProductionToSchedules < ActiveRecord::Migration[5.0]
  def change
    add_reference :schedules, :production, foreign_key: true
  end
end
