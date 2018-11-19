class AddArtistToTracks < ActiveRecord::Migration[5.1]
  def change
    add_column :tracks, :artist, :string
  end
end
