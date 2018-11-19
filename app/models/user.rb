require 'bcrypt'

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  has_many :ratings, dependent: :destroy
  has_many :tracks_users
  has_many :tracks, through: :tracks_users

  include BCrypt

  def password
    @password ||= Password.new(password_hash) unless password_hash.nil?
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
