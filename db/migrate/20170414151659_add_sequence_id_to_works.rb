class AddSequenceIdToWorks < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :sequence_id, :integer
  end
end
