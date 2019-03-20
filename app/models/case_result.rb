require 'csv'

class CaseResult < ApplicationRecord
  serialize :result_array, Array
  serialize :path_array, Array

  belongs_to :case

  scope :find_case_name, -> (case_name) { where("case_name like ?", "%#{case_name}%") if case_name.present? }
  scope :find_case_type, -> (case_type) { where(case_type: case_type) if case_type.present? }
  
  def case_type_view
    case case_type
    when "S"
      "低强度地震"
    when "M1"
      "中等强度地震"
    when "L"
      "高强度地震"
    end
  end
  
  def self.to_csv
    attributes = %w{case_name case_tag case_desc case_type_view result_text path_text}

    CSV.generate(headers: true) do |csv|
      csv << %w{编号 案例名称 案例关键词 案例描述 地震强度 灾害后果 灾害演化路径}

      find_each.with_index do |cr, index|
        csv << attributes.map{ |attr| cr.send(attr) }.unshift(index + 1)
      end
    end.encode('gb2312', :invalid => :replace, :undef => :replace, :replace => "?")
  end

  def result_text
    result_array.join("\r\n")
  end

  def path_text
    path_array.join("\r\n")
  end

  def case_desc
    case&.desc
  end
end
