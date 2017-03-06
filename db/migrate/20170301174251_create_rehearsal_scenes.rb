class CreateRehearsalScenes < ActiveRecord::Migration[5.0]
  def change
    create_table :rehearsal_scenes do |t|
      t.references :rehearsal, foreign_key: true
      t.references :scene, foreign_key: true
      t.datetime :expected_start
      t.datetime :expected_end
      t.datetime :actual_start
      t.datetime :actual_end

      t.timestamps
    end
  end
end
