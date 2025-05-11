defmodule Tunez.Music.ArtistFollower do
  use Ash.Resource, otp_app: :tunez, domain: Tunez.Music, data_layer: AshPostgres.DataLayer

  postgres do
    table "artist_followers"
    repo Tunez.Repo
  end
end
