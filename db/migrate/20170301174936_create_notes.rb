class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.references :rehearsal, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
