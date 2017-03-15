class AddCellEmailToPeople < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :cell, :string
    add_column :people, :email, :string
  end
end
