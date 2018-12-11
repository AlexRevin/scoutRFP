class Task < ApplicationRecord
  has_many :tags
  accepts_nested_attributes_for :tags
end
