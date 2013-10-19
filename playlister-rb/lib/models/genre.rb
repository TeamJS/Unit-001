require_relative '../../config/environment'

class Genre
  attr_accessor :name, :songs, :artists

  def initialize
    @songs = []
    @artists = []
  end

  # def artists
  #   @artists = self.songs.collect do |song|
  #     song.artist
  #   end
  # end

end
