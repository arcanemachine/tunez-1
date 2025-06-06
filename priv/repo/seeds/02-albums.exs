# Seed data for some sample albums.
# Text content generated by ChatGPT 4, album covers generated by Midjourney.

require Ash.Query

artist_names = Enum.map(Tunez.Seeder.artists(), & &1.name)

artists =
  Tunez.Music.Artist
  |> Ash.Query.filter(name in ^artist_names)
  |> Ash.read!()

artist_ids = Enum.map(artists, & &1.id)
artist_name_map = Enum.map(artists, &{&1.name, &1.id}) |> Map.new()

# Delete the existing records for albums from the seed data artists
Tunez.Music.Album
|> Ash.Query.filter(artist_id in ^artist_ids)
|> Ash.bulk_destroy!(:destroy, %{}, strategy: :stream, authorize?: false)

# And re-insert fresh copies of them
Tunez.Seeder.albums()
|> Enum.map(fn album ->
  album
  |> Map.put(:artist_id, Map.get(artist_name_map, album.artist_name))
  |> Map.drop([:artist_name, :tracks])
end)
|> Enum.filter(& &1.artist_id)
|> Ash.bulk_create!(Tunez.Music.Album, :create, return_errors?: true, authorize?: false)
