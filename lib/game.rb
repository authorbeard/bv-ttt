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

  def over?
    draw? || winner?
  end

  def do_turn
binding.pry

  end

  def current_board
    @state ||= board.state
  end

  def current_player
    @current_player ||= first_or_next
  end

  def next_player
    current_player.piece == "X" ? player_y : player_x
  end

  def player_x
    players.first
  end

  def player_y
    players.last
  end

  def first_or_next
    first_turn? ? players[rand(10) % 2] : next_player
  end

  def first_turn?
    current_board.length == current_board.open_spaces.count
  end

end