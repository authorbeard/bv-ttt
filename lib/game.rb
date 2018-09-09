class Game
  attr_accessor :board, :players, :type, :winner, :current_player, :last_player

  def initialize(game_type="1")
    @board   = Board.new
    @players = initialize_players(game_type)
    set_players
  end


  def initialize_players(game_type)
    if game_type == "1"
      [Human.new(piece: "X"), Computer.new(piece: "O")]
    else
      [Human.new(piece: "X"), Human.new(piece: "O")]
    end
  end

  def over?
    winner? || draw?
  end

  def do_turn(selected_position = nil)
    chosen_pos = current_player.choose_move(board)
    MoveService.make_move(board, chosen_pos, current_player)
    toggle_players
  end

  def current_board
    @state ||= board.state
  end

  def winner?
    @winner = WinChecker.winner?(board)
  end

  def draw?
    board.taken_spaces == board.positions.count
  end

  def set_players
    first_index = rand(10) % 2
    players         = @players.dup
    @current_player = players.slice!(first_index, 1).first
    @last_player    = players.shift
  end

  def update_players
    player_names = STDIN.gets.strip.split(",")
    players.each_with_index do |player, i| 
      player.name = player_names[i] unless player_names[i].nil?
    end
  end

  def toggle_players
    @last_player, @current_player = @current_player, @last_player
  end

  def player_x
    players.first
  end

  def player_o
    players.last
  end

  def first_turn?
    current_board.length == board.open_spaces.count
  end
end