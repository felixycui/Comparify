class Rating < ApplicationRecord
  validates :value, presence: true
  belongs_to :user
  # belongs_to :track
end
