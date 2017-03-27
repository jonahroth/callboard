class CreateWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :works do |t|
      t.string :name
      t.string :type
      t.integer :duration
      t.integer :break_duration

      t.timestamps
    end
  end
end
