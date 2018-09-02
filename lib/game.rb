class Game
  attr_accessor :board, :players

  def initialize
    @board   = Board.new
    @players = initialize_players
  end


  def initialize_players
    [Player.new("x"), Player.new("o")]
  end

end