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
    new_game
  end

  def new_game
    game_type = STDIN.gets.strip

    if game_type == "1"
      @game = Game.new("pvc")
    else
      @game = Game.new("pvp")
      puts @comms.player_options_menu
    end

    turn
  end

  def turn

  end


  def clear_screen
    puts "\e[H\e[2J"
  end
end