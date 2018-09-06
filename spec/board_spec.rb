require "spec_helper"

RSpec.describe "../lib/board.rb" do
  describe Board do 

    before :each do 
      @board = Board.new
    end

    it "initializes in an empty state" do 
      empty_board = (1..9).to_a.each_with_object({}) do | position, board|
        board[position] = nil
      end

      expect(@board.state).to eq(empty_board)
    end

    it "initialized at 3X3 if no size is given" do 
      expect(@board.state.length).to eq 9
    end

    it "can be initialized at any size 3x3 or more" do 
      state = Board.new(5).state
      expect(state.length).to eq 25
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

    it "calculates the row for any position" do 
      [1, 2, 3].each do |pos|
        expect(@board.row(pos)).to eq 1
      end

      [7, 8, 9].each do |pos|
        expect(@board.row(pos)).to eq 3
      end

      board = Board.new(5)
      (1..5).to_a.each do |pos|
        expect(board.row(pos)).to eq 1
      end

      (16..20).to_a.each do |pos|
        expect(board.row(pos)).to eq 4
      end
    end

    it "calculates the column for any position" do 
      [2, 5, 8].each do |pos|
        expect(@board.col(pos)).to eq 2
      end

      [3, 6, 9].each do |pos|
        expect(@board.col(pos)).to eq 3
      end

      board = Board.new(5)
      [1, 6, 11, 16, 21].to_a.each do |pos|
        expect(board.col(pos)).to eq 1
      end

      [4, 9, 14, 19, 24].to_a.each do |pos|
        expect(board.col(pos)).to eq 4
      end
    end
  end
end