class Game
  attr_accessor :board, :players, :type, :last_player

  def initialize(type="pvc")
    @board   = Board.new
    @players = initialize_players
    @type    = type
  end


  def initialize_players
    [Player.new(piece: "X"), Player.new(piece: "O")]
  end

  def over?
    if turns_taken >= 5
      winner? || draw?
    else
      false
    end
  end

  def do_turn
    p = current_player

  end

  def current_board
    @state ||= board.state
  end

  def winner?
    WinChecker.winner?(board)
  end

  def draw?
    if turns_taken == 9
      true
    else
      WinChecker.draw?(board)
    end
  end

  def current_player
    first_or_next
  end

  def first_or_next
    first_turn? ? players[rand(10) % 2] : next_player
  end

  def next_player
    last_player.piece == "X" ? player_y : player_x
  end

  def player_x
    players.first
  end

  def player_y
    players.last
  end

  def first_turn?
    current_board.length == current_board.open_spaces.count
  end

  def turns_taken
    current_board.taken_spaces.count
  end

end