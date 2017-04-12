class AddProductionToRehearsals < ActiveRecord::Migration[5.0]
  def change
    add_reference :rehearsals, :production, foreign_key: true
  end
end
