require "spec_helper"

RSpec.describe "../lib/game_controller.rb" do 
  describe GameController do
    describe "#start" do 
      it "renders the main menu" do 
        allow_any_instance_of(GameController).to receive(:set_up_game).and_return(true)
        expect_any_instance_of(CommunicatorService).to receive(:main_menu)
        GameController.start
      end

      it "initializes a new game" do 
        expect_any_instance_of(GameController).to receive(:set_up_game)
        GameController.start
      end
    end

    describe "#set_up_game" do 

      it "initializes a player-versus-computer game when a user selects 1" do 
        allow(STDIN).to receive(:gets).and_return("1\n")
        allow_any_instance_of(Game).to receive(:over?).and_return true
        ctrl = GameController.new
        ctrl.set_up_game
        expect(ctrl.game.type).to eq "pvc"
      end

      it "lets the human player select a name" do 
        allow(STDIN).to receive(:gets).and_return("1\n")
        allow_any_instance_of(Game).to receive(:over?).and_return true
        ctrl = GameController.new
        ctrl.set_up_game
        expect(ctrl.game.player_x.name).to eq "1"
      end

      it "lets the human player keep the default name" do 
        allow(STDIN).to receive(:gets).ordered.and_return("1\n")
        allow(STDIN).to receive(:gets).ordered.and_return(" \n")
        allow_any_instance_of(Game).to receive(:over?).and_return true
        ctrl = GameController.new
        ctrl.set_up_game
        expect(ctrl.game.player_x.name).to eq "Player X"
      end

      it "initializes a player-versus-player game when a user selects 1" do 
        allow(STDIN).to receive(:gets).and_return("2\n")
        allow_any_instance_of(Game).to receive(:over?).and_return true
        ctrl = GameController.new
        ctrl.set_up_game
        expect(ctrl.game.type).to eq "pvp"
      end

      it "renders the player options menu for pvp games" do 
        allow(STDIN).to receive(:gets).and_return("Kevin, Bilinda\n")
        allow_any_instance_of(GameController).to receive(:update_players).and_return("")
        allow_any_instance_of(Game).to receive(:over?).and_return true
        ctrl = GameController.new
        ctrl.set_up_game
        expect(ctrl.comms).to receive(:player_options_menu).once
        ctrl.set_up_game
      end

      it "updates the players with the options entered at the menu" do
        @player_o = double(name: "Freeney", piece: "X")
        @player_x = double(name: "Mathis", piece: "O") 
        allow(STDIN).to receive(:gets).and_return("Freeney, Mathis")
        ctrl = GameController.new
        ctrl.game = Game.new("pvp")
        ctrl.update_players
        expect(ctrl.game.players.first.name).to eq "Freeney"
      end

      it "starts the game already" do 
        allow(STDIN).to receive(:gets).and_return("1\n")
        allow_any_instance_of(Game).to receive(:over?).and_return(true)
        allow_any_instance_of(GameController).to receive(:computer_is_next).and_return(false)
        allow_any_instance_of(Game).to receive(:do_turn).with(any_args).and_return("")
        expect_any_instance_of(GameController).to receive(:play).at_least(:once)
        ctrl = GameController.start
      end
    end

    context "gameplay" do 
      it "it renders the game complete call if the game is over" do 
        allow(STDIN).to receive(:gets).and_return("1\n")
        allow_any_instance_of(GameController).to receive(:thats_all_folks).and_return(nil)
        expect_any_instance_of(Game).to receive(:over?).and_return(true)
        ctrl = GameController.start
      end

      it "displays the board and alerts the game to expect another turn" do 
        # allow_any_instance_of(Game).to receive(:current_board).and_return({})
        # allow_any_instance_of(Game).to receive(:current_player).and_return(double(name: "Player X", piece: "X"))
        # allow_any_instance_of(CommunicatorService).to receive(:next_turn).with(any_args).and_return(true)
        expect_any_instance_of(CommunicatorService).to receive(:next_turn).and_return("")
        expect_any_instance_of(Game).to receive(:do_turn).at_least(:once).and_return(false)
        ctrl = GameController.new
        ctrl.game = Game.new("pvc")
        ctrl.next_turn
      end

      it "checks whether it's the computer's turn for player-versus-computer" do 
        ctrl      = GameController.new
        ctrl.game = Game.new("pvc")
        allow_any_instance_of(Game).to receive(:do_turn).and_return("")
        allow_any_instance_of(Game).to receive(:over?).and_return true
        expect_any_instance_of(GameController).to receive(:computer_is_next)
        ctrl.next_turn
      end

      it "makes a computer move if for pvc games" do 
        allow_any_instance_of(Game).to receive(:do_turn).and_return("")
        allow_any_instance_of(Game).to receive(:over?).and_return true
        expect_any_instance_of(Game).to receive(:do_turn).with(any_args)
        ctrl      = GameController.new
        ctrl.game = Game.new("pvc")
        last      = ctrl.game.last_player
        ctrl.game.toggle_players if last == ctrl.game.player_x
        ctrl.next_turn

        expect(ctrl.game.last_player).to be(ctrl.game.player_o)
      end
    end
  end
end
