require "spec_helper"

RSpec.describe "../lib/board.rb" do
  describe Board do 

    before :each do 
      @board = Board.new
    end

    it "initializes in an empty state" do 
      empty_board = (0..8).to_a.each_with_object({}) do | position, board|
        board[position] = nil
      end

      expect(@board.state).to eq(empty_board)
    end

    it "records players' moves" do  
      @board.update_state(5, "X")

      expect(@board.state.values.all?(&:nil?)).to be false
    end

    it "can check for a valid position" do 
      expect(@board.valid_position?(10)).to be false
      expect(@board.valid_position?(5)).to be true
    end

    it "keeps track of occupied spaces" do 
      @board.state[0] = "O"
      expect(@board.space_is_available?(0)).to be false
      expect(@board.space_is_available?(8)).to be true
    end
  end
end