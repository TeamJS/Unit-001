require_relative '../../config/environment'

class Artist
  attr_accessor :name, :songs, :genres

  @ARTISTS = []

  def initialize
    self.class.all << self  
    #this is b/c u can't call @ARTISTS in instance methods
  end

  def add_song(song)
    @songs ||= []
    @songs << song
    @genres ||= []
    @genres << song.genre
  end

#------------CLASSS METHODS--------------

  def self.reset_artists
    @ARTISTS.clear
    # ALWAYS use clear instead of =[]
  end

  def self.all
    @ARTISTS
  end

  def self.count
    @ARTISTS.length
  end

end
