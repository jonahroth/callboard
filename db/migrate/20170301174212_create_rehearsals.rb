class CreateRehearsals < ActiveRecord::Migration[5.0]
  def change
    create_table :rehearsals do |t|
      t.string :title

      t.timestamps
    end
  end
end
