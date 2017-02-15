class CreateScenes < ActiveRecord::Migration[5.0]
  def change
    create_table :scenes do |t|
      t.string :number
      t.references :production, foreign_key: true

      t.timestamps
    end
  end
end
