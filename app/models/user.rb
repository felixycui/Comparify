require 'bcrypt'

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validate :present_in_api
  has_many :ratings, dependent: :destroy
  has_many :tracks_users, dependent: :destroy
  has_many :tracks, through: :tracks_users

  include BCrypt

  def present_in_api
    errors.add(:base, 'Must be a valid user in Spotify') if username && !username.empty? && user_find.nil?
  end

  # note that username must be the user ID found at the end of the Spotify URI
  def user_find
    RSpotify::User.find(username)
  end

  def all_tracks_array
    arr = []
    user_find.playlists.each do |playlist|
      playlist.tracks.each do |track|
        next unless track.artists.first.name.present?
        arr << track
      end
    end
    arr
  end

  def similarity_score(user)
    (all_tracks_array.map(&:name) & user.all_tracks_array.map(&:name)).length
  end

  def similar_tracks_array(user)
    all_tracks_array & user.all_tracks_array
  end

  def rank_hash
    hash = {}
    User.all.each do |user|
      next if self == user
      next if user.user_find.nil?
      name = user.username
      hash[name] = similarity_score(user)
    end

    hash.sort_by { |name, score| -score }
  end

  def password
    @password ||= Password.new(password_hash) unless password_hash.nil?
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
