class AddProductionToWork < ActiveRecord::Migration[5.0]
  def change
    add_reference :works, :production, foreign_key: true
  end
end
