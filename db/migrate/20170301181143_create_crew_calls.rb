class CreateCrewCalls < ActiveRecord::Migration[5.0]
  def change
    create_table :crew_calls do |t|
      t.references :crew_role, foreign_key: true
      t.references :rehearsal, foreign_key: true

      t.timestamps
    end
  end
end
