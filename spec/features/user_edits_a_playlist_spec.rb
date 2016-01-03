require 'rails_helper'

RSpec.feature "User edits an existing playlist" do
  scenario "They can see updated data for an existing playlist" do
    playlist                            = create(:playlist_with_songs)
    song_one, song_two, song_three      = playlist.songs
    updated_playlist_name               = "Not My Jams"
    new_song                            = create(:song, title: "New Song")

    visit playlist_path(playlist)
    click_on "Edit"
    fill_in "playlist_name", with: updated_playlist_name
    uncheck("song-#{song_one.id}")
    check("song-#{new_song.id}")
    click_on "Update Playlist"

    expect(page).to have_content updated_playlist_name
    expect(page).to have_content new_song.title
    expect(page).to_not have_content song_one.title
  end
end
