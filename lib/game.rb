class Game
  attr_accessor :board, :players, :type

  def initialize(type="pvc")
    @board   = Board.new
    @players = initialize_players
    @type    = type
  end


  def initialize_players
    [Player.new("x"), Player.new("o")]
  end

  def move
    
  end

end