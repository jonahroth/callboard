class AddDepartmentToCrewRoles < ActiveRecord::Migration[5.0]
  def change
    add_reference :crew_roles, :department, foreign_key: true
  end
end
