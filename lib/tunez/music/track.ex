defmodule Tunez.Music.Track do
  use Ash.Resource, otp_app: :tunez, domain: Tunez.Music, data_layer: AshPostgres.DataLayer

  postgres do
    table "tracks"
    repo Tunez.Repo
  end
end
