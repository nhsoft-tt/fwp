class Case < ApplicationRecord
  has_many :case_results
  
  scope :find_name, -> (name) { where("name like ?", "%#{name}%") if name.present? }
  scope :find_username, -> (username) { where("username like ?", "%#{username}%") if username.present? }
  scope :find_tag, -> (tag) { where("tag like ?", "%#{tag}%") if tag.present? }
end
