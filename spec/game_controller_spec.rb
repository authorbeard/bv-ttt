require "spec_helper"

RSpec.describe "../lib/game_controller.rb" do 
  describe GameController do 
    describe "#start" do 
      it "renders the main menu" do 
        expect(STDOUT).to receive(:puts).with(CommunicatorService::MAIN_MENU)
      end
    end

  end
end
