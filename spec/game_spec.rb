require "spec_helper"

RSpec.describe "./lib/game.rb" do 
  before(:each) do 
    empty_board = (0..9).to_a.each_with_object({}) do | position, board|
      board[position] = nil
    end
    allow(Board).to receive(:new).and_return(empty_board)
  end

  describe Game do
    it "initializes with an empty board" do 
      expect(Game.new.board).to be_a(Hash)
    end

  end
end