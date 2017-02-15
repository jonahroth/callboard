class CreateCrewRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :crew_roles do |t|
      t.references :person, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
