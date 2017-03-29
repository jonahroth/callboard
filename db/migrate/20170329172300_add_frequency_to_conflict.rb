class AddFrequencyToConflict < ActiveRecord::Migration[5.0]
  def change
    add_column :conflicts, :frequency, :string
  end
end
