class CreatePersonWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :person_works do |t|
      t.references :person, foreign_key: true
      t.references :work, foreign_key: true

      t.timestamps
    end
  end
end
