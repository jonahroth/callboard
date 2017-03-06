class DepartmentNote < ApplicationRecord
  belongs_to :department
  belongs_to :note
end
