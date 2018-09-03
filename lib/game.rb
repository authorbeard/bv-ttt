class Game
  attr_accessor :board, :players, :type

  def initialize(type="pvc")
    @board   = Board.new
    @players = initialize_players
    @type    = type
  end


  def initialize_players
    [Player.new(piece: "X"), Player.new(piece: "O")]
  end

  def update_player_names
    
  end

  def move

  end

end