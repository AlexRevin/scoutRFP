class Tag < ApplicationRecord
  # in Rails5, belongs_to records fail without associated object assigned
  belongs_to :task, optional: true
end
