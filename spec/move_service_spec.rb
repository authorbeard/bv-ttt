require "spec_helper"


RSpec.describe "../lib/move_service.rb" do 
  describe MoveService do 
    before :each do 
      @board = Board.new
      @svc   = MoveService.new(board)
    end

    context "valid moves" do 
      it "updates the board's state" do 
        expect{
          @svc.make_move(8, "X")
        }.to change(@board, :state)
      end

      it "checks that the position is valid" do 


      end

      it "checks that the position is unoccupied" do 


      end

    end

    it "does not allow moves to invalid positions" do  
      expect{
        @vcs.move(10, "X")
      }.not_to change(@board, :state)
    end

    it "does not allow moves to occupied spaces" do  
      @board.state[5]="X"

      expect {
        @board.move(5, "O")
      }.not_to change(@board, :state)
    end


  end
end
