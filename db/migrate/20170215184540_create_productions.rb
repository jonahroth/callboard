class CreateProductions < ActiveRecord::Migration[5.0]
  def change
    create_table :productions do |t|
      t.string :title
      t.date :first_rehearsal
      t.date :last_rehearsal

      t.timestamps
    end

    add_reference :people, :production, foreign_key: true
  end
end
