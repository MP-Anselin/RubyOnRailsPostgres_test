class Job < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :applieds, dependent: :destroy
  scope :filter_by_title, -> (title) { where title: title }

  serialize :spoken_languages, Array
  serialize :shift_dates, Array

end
