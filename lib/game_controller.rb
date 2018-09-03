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
    else
      @game = Game.new("pvp")
      puts @comms.player_options_menu
      update_players
    end

    play
  end

  def play
    until game_over
      clear_screen
      next_turn
    end
    puts thats_all_folks
  end

  def update_players
    player_names = STDIN.gets.strip.split(",")
    game.players.each_with_index{|player, i| player.name = player_names[i]}
  end

  def game_over
    game.over?
  end

  def next_turn
    puts @comms.next_turn(game)
    game.do_turn
  end

  def thats_all_folks
    puts "DONE"
  end


  def clear_screen
    puts "\e[H\e[2J"
  end
end