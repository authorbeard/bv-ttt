require "spec_helper"


RSpec.describe "../lib/board.rb" do
  describe Board do 
    it "initializes as an empty hash" do 
      empty_board = (0..8).to_a.each_with_object({}) do | position, board|
        board[position] = nil
      end

      expect(Board.new).to eq(empty_board)
    end
  end
end