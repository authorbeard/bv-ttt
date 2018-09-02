require "spec_helper"

RSpec.describe "./lib/game.rb" do 
  before(:each) do 
    empty_board = (0..8).to_a.each_with_object({}) do | position, board|
      board[position] = nil
    end
    allow(Board).to receive(:new).and_return(empty_board)
    @player_x = double("player_x", piece: "X")
    @player_o = double("player_o", piece: "O")
    allow_any_instance_of(Game).to receive(:initialize_players).and_return([@player_x, @player_o])
    @game = Game.new
  end

  describe Game do
    it "initializes with an empty board" do 
      expect(@game.board).to be_a(Hash)
      expect(@game.board.keys.count).to eq 9
      expect(@game.board.values.uniq.all?(&:nil?)).to be true
    end

    it "initializes with two players" do 
      players = @game.players
      expect(players.count).to eq 2
      expect([@player_x, @player_o].all?{|p| players.include?(p)}).to be true
    end

    it "initializes with a game type" do 
      expect(@game.type).not_to be nil
    end

    it "can be initialized as player-vs-player" do 
      expect(Game.new("pvp").type).to eq("pvp")
    end

    it "can be initialized as player-vs-computer" do 
      expect(Game.new("pvc").type).to eq("pvc")
    end

    

  end
end