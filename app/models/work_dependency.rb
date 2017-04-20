class WorkDependency < ApplicationRecord
  belongs_to :dependent, class_name: 'Work', foreign_key: :dependent_id
  belongs_to :dependency, class_name: 'Work', foreign_key: :dependency_id
end
