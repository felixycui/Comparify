class WelcomeController < ApplicationController
  def index
    return unless logged_in?
    if current_user.tracks.empty?
      current_user.all_tracks_array.each do |track|
        current_user.tracks << Track.create(name: track.name, artist: track.artists.first.name)
      end
      #current_user.tracks = current_user.all_tracks_array
    end
  end
end
