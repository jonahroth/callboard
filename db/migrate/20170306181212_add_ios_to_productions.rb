class AddIosToProductions < ActiveRecord::Migration[5.0]
  def change
    add_column :productions, :ios_code, :string
    add_column :productions, :ios_expiration, :datetime
    add_column :people, :ios_uuid, :string
  end
end
