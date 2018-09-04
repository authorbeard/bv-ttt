require "spec_helper"

RSpec.describe "../lib/move_service.rb" do 
  describe MoveService do 
    before :each do 
      @board    = Board.new
      @player_x = double("player_x", piece: "X")
      @player_o = double("player_o", piece: "O")
    end

    describe "#make_move" do    
      it "checks that the position is valid" do 
        expect_any_instance_of(Board).to receive(:valid_position?)
        MoveService.make_move(@board, 4, @player_x)
      end

      it "checks that the position is unoccupied" do 
        expect_any_instance_of(Board).to receive(:space_is_available?)
        MoveService.make_move(@board, 4, @player_x)
      end

      it "updates the board's state" do 
        expect_any_instance_of(Board).to receive(:update_state).with(4, @player_x.piece)
        MoveService.make_move(@board, 4, @player_x)
      end

      it "returns true for valid moves" do 
        expect(MoveService.make_move(@board, 4, @player_o)).to eq true
      end

      it "returns false for invalid moves" do 
        MoveService.make_move(@board, 7, @player_o)
        expect(MoveService.make_move(@board, 10, @player_o)).to be false
        expect(MoveService.make_move(@board, 7, @player_x)).to be false
      end
    end
  end
end
