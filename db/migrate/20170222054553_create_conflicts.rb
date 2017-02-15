class CreateConflicts < ActiveRecord::Migration[5.0]
  def change
    create_table :conflicts do |t|
      t.datetime :start
      t.datetime :end
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
