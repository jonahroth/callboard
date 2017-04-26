class RemoveFieldsFromProduction < ActiveRecord::Migration[5.0]
  def change
    remove_column :productions, :first_rehearsal, :datetime
    remove_column :productions, :last_rehearsal, :datetime
  end
end
