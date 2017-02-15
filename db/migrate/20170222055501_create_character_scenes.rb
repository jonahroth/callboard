class CreateCharacterScenes < ActiveRecord::Migration[5.0]
  def change
    create_table :character_scenes do |t|
      t.references :character, foreign_key: true
      t.references :scene, foreign_key: true

      t.timestamps
    end
  end
end
