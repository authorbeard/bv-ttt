class Game
  attr_accessor :board, :players, :type, :winner, :current_player, :last_player

  def initialize(type="pvc")
    @board   = Board.new
    @players = initialize_players
    @type    = type
    set_players
  end


  def initialize_players
    [Player.new(piece: "X"), Player.new(piece: "O")]
  end

  def over?
    winner? || draw?
  end

  def do_turn
    position = STDIN.gets.strip.to_i - 1
    MoveService.make_move(board, position, current_player)
    toggle_players
  end

  def current_board
    @state ||= board.state
  end

  def winner?
    @winner = WinChecker.winner?(board)
  end

  def draw?
    if turns_taken == 9
      true
    else
      WinChecker.draw?(board)
    end
  end

  def set_players
    first_index = rand(10) % 2
    players         = @players.dup
    @current_player = players.slice!(first_index, 1).first
    @last_player    = players.shift
  end

  def toggle_players
    @last_player, @current_player = @current_player, @last_player
  end

  def player_x
    players.first
  end

  def player_y
    players.last
  end

  def first_turn?
    current_board.length == board.open_spaces.count
  end

  def turns_taken
    board.taken_spaces.count + 1
  end

end