require "spec_helper"


RSpec.describe "../lib/board.rb" do
  describe Board do 
    it "initializes in an empty state" do 
      empty_board = (0..8).to_a.each_with_object({}) do | position, board|
        board[position] = ""
      end

      expect(Board.new.state).to eq(empty_board)
    end

    it "stores players' moves" do 
      board = Board.new
      board.state[5]="X"

      expect(board.state.values.all?(&:empty?)).to be false
    end
  end
end