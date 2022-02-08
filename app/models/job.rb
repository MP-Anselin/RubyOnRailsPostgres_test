class Job < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :applies, dependent: :destroy
  scope :filter_by_title, -> (title) { where title: title }
  scope :filter_by_language, -> (language) { where spoken_languages: [language] }

  serialize :spoken_languages, Array
  serialize :shift_dates, Array

end
