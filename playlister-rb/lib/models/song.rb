require_relative '../../config/environment'

class Song
  attr_accessor :name, :genre, :artist

  def genre=(genre)
    @genre = genre
    genre.songs << genre
  end

end
