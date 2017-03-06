class CreateDepartmentNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :department_notes do |t|
      t.references :department, foreign_key: true
      t.references :note, foreign_key: true

      t.timestamps
    end
  end
end
