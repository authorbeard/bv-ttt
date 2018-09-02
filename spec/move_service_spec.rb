require "spec_helper"

RSpec.describe "../lib/move_service.rb" do 
  describe MoveService do 
    before :each do 
      @svc      = MoveService.new
      @player_x = double("player_x", piece: "X")
      @player_o = double("player_o", piece: "O")
    end
   
    it "updates the board's state" do 
      expect_any_instance_of(Board).to receive(:update_state).with(4, @player_x.piece)
      @svc.make_move(4, @player_x)
    end

    it "checks that the position is valid" do 
      expect_any_instance_of(Board).to receive(:valid_position?)
      @svc.make_move(4, @player_x)
    end

    it "checks that the position is unoccupied" do 
      expect_any_instance_of(Board).to receive(:space_is_available?)
      @svc.make_move(4, @player_x)
    end
  end
end
