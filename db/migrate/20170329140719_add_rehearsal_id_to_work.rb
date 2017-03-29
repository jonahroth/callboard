class AddRehearsalIdToWork < ActiveRecord::Migration[5.0]
  def change
    add_reference :works, :rehearsal, foreign_key: true
  end
end
