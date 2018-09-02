require "spec_helper"

RSpec.describe "./lib/game.rb" do 
  describe Game do
    it "initializes with an empty board" do 
      expect(Game.new.board).to be_a(Hash)
    end

  end
end