class GameController
  attr_accessor :game, :comms

  def self.start
    new.tap{|ctrl| ctrl.start }
  end

  def initialize
    @comms = CommunicatorService.new
  end

  def start
    clear_screen
    puts @comms.main_menu
    set_up_game
  end

  def set_up_game
    game_type = STDIN.gets.strip

    if game_type == "1"
      @game = Game.new("pvc")
      clear_screen
      puts @comms.player_name_menu
      update_players
    else
      @game = Game.new("pvp")
      clear_screen
      puts @comms.player_options_menu
      update_players
    end

    play
  end

  def play
    until game.over?
      clear_screen
      next_turn
    end
    puts thats_all_folks
  end

  def update_players
    player_names = STDIN.gets.strip.split(",")
    game.players.each_with_index do |player, i| 
      player.name = player_names[i] unless player_names[i].nil?
    end
  end

  def next_turn
    if computer_is_next
      clear_screen
      puts computer_turn
      sleep 2
    end

    clear_screen
    puts @comms.next_turn(game)
    game.do_turn
  end

  def thats_all_folks
    puts @comms.game_over(game.winner || "draw")
  end

  def computer_is_next
    game.last_player == game.player_x && game.type == "pvc"
  end

  def computer_turn
    available = game.board.open_spaces.keys
    selected  = available[rand(available.length)]
    game.do_turn(selected)
    @comms.computer_turn(game.current_board, selected)
  end


  def clear_screen
    puts "\e[H\e[2J"
  end
end