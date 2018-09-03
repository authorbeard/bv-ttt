require "spec_helper"

RSpec.describe "../lib/game_controller.rb" do 
  describe GameController do
    describe "#start" do 
      it "renders the main menu" do 
        expect_any_instance_of(CommunicatorService).to receive(:main_menu)
        GameController.start
      end

      it "initializes a new game" do 
        expect_any_instance_of(GameController).to receive(:new_game)
        GameController.start
      end
    end

    describe "#new_game" do 
      it "initializes a player-versus-computer game when a user selects 1" do 
        allow(STDIN).to receive(:gets).and_return("1\n")
        expect(Game).to receive(:new).with("pvc")
        GameController.new.new_game
      end

      it "initializes a player-versus-player game when a user selects 1" do 
        allow(STDIN).to receive(:gets).and_return("2\n")
        expect(Game).to receive(:new).with("pvp")
        GameController.new.new_game
      end

      it "renders the player options menu for pvp games" do 
        allow(STDIN).to receive(:gets).and_return("2\n")
        ctrl = GameController.new
        expect(ctrl.comms).to receive(:player_options_menu)
        ctrl.new_game
      end
    end
  end
end
