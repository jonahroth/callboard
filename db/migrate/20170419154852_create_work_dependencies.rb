class CreateWorkDependencies < ActiveRecord::Migration[5.0]
  def change
    create_table :work_dependencies do |t|
      t.references :dependent
      t.references :dependency
      t.timestamps
    end
  end
end
