class Job < ApplicationRecord
  scope :filter_by_title, -> (title) { where title: title }
end
