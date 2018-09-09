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
    game_type = get_game_type
    @game = Game.new(game_type)
    clear_screen
    puts @comms.send("player_menu_#{game_type}")
    game.update_players
    play
  end

  def get_game_type
    STDIN.gets.strip
  end

  def play
    until game.over?
      next_turn
    end
    puts thats_all_folks
  end

  def next_turn
    clear_screen
    puts @comms.next_turn(game)
    game.do_turn
  end

  def thats_all_folks
    clear_screen
    puts @comms.format_board(game.board)
    puts @comms.game_over(game.winner || "draw")
  end

  def clear_screen
    puts "\e[H\e[2J"
  end
end