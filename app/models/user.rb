require 'bcrypt'

class User < ActiveRecord::Base
  has_many :jobs, dependent: :destroy
  has_many :applieds, dependent: :destroy
  include BCrypt

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  scope :filter_by_email, -> (email) { where email: email }

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
