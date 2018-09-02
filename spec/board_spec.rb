require "spec_helper"


RSpec.describe "../lib/board.rb" do
  describe Board do 
    it "initializes in an empty state" do 
      empty_board = (0..8).to_a.each_with_object({}) do | position, board|
        board[position] = ""
      end

      expect(Board.new.state).to eq(empty_board)
    end

    it "records players' moves" do 
      board = Board.new
      board.move(5, "X")

      expect(board.state.values.all?(&:empty?)).to be false
    end

    it "does not allow moves to invalid positions" do 
      board = Board.new
      expect{
        board.move(10, "X")
      }.not_to change(board, :state)
    end

    it "does not allow moves to occupied spaces" do 
      board = Board.new
      board.state[5]="X"

      expect {
        board.move(5, "O")
      }.not_to change(board, :state)

    end
  end
end