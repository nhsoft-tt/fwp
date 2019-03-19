class CaseResult < ApplicationRecord
  serialize :result_array, Array
  serialize :path_array, Array

  belongs_to :case

  scope :find_case_name, -> (case_name) { where("case_name like ?", "%#{case_name}%") if case_name.present? }
  scope :find_case_type, -> (case_type) { where(case_type: case_type) if case_type.present? }
end
