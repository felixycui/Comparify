class Track < ApplicationRecord
  validates :name, presence: true
  validates :artist, presence: true
  has_many :tracks_users, dependent: :destroy
  has_many :users, through: :tracks_users
  has_many :ratings, dependent: :destroy

  def track_search
    RSpotify::Track.search("#{artist} #{name}")
  end

  def spotify_uri
    return nil unless valid?
    track_search.first.uri
  end
end
