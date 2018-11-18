class CreateTracksUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks_users do |t|
      t.references :track, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
