class AddTypeToConflicts < ActiveRecord::Migration[5.0]
  def change
    add_column :conflicts, :type, :string
  end
end
