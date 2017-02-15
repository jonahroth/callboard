class CreateCheckIns < ActiveRecord::Migration[5.0]
  def change
    create_table :check_ins do |t|
      t.references :person, foreign_key: true
      t.references :rehearsal, foreign_key: true
      t.datetime :checked_in_at

      t.timestamps
    end
  end
end
