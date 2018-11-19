class Track < ApplicationRecord
  validates :name, presence: true
  validates :artist, presence: true
  validate :track_in_api?
  has_many :tracks_users, dependent: :destroy
  has_many :users, through: :tracks_users
  has_many :ratings, dependent: :destroy

  def track_in_api?
    test_bool = name && !name.empty? && track_search.empty?
    errors.add(:base, 'Must be a valid track for the artist in Spotify') if test_bool
  end

  def track_search
    RSpotify::Track.search("#{artist} #{name}")
  end

end
