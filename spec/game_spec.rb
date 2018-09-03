require "spec_helper"

RSpec.describe "./lib/game.rb" do 
  before(:each) do 
    empty = Hash.new{|hash, key| hash[key] = "" }
    initial_state = (0..8).to_a.map{|i| empty[i]}
    empty_board = double(state: empty)
    allow(Board).to receive(:new).and_return(empty_board)
    @player_x = double("player_x", piece: "X")
    @player_o = double("player_o", piece: "O")
    allow_any_instance_of(Game).to receive(:initialize_players).and_return([@player_x, @player_o])
    @game = Game.new
  end

  describe Game do
    it "initializes with an empty board" do 
      expect(@game.board.state).to be_a(Hash)
      expect(@game.board.state.keys.count).to eq 9
      expect(@game.board.state.values.all?(&:empty?)).to be true
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

    context "gameplay" do 
      context "#over?" do 
        it "returns false if there haven't been enough moves to win" do 
          g = Game.new
          allow_any_instance_of(Game).to receive(:turns_taken).and_return(4)
          allow_any_instance_of(Game).to receive(:winner?).and_return(true)
          expect(g.over?).to be false
        end

        it "checks for a winner if there have been enough moves" do 
          g = Game.new
          allow_any_instance_of(Game).to receive(:turns_taken).and_return(7)
          allow_any_instance_of(Game).to receive(:draw?).and_return(true)
          expect(WinChecker).to receive(:winner?)
          g.over?
        end

        it "checks for a draw if there is no winner" do
          g = Game.new
          allow_any_instance_of(Game).to receive(:turns_taken).and_return(7)
          allow_any_instance_of(Game).to receive(:winner?).and_return(false)
          expect(WinChecker).to receive(:draw?)
          g.over?
        end

        it "is true when all of the spaces are full" do 
          allow_any_instance_of(Game).to receive(:winner?).and_return(false)
          allow_any_instance_of(Game).to receive(:turns_taken).and_return(9)
          g = Game.new
          expect(g.over?).to be true
        end
      end

      it "sets the current player" do 
        g = Game.new
        allow(g.board).to receive(:open_spaces).and_return(0)
        expect_any_instance_of(Game).to receive(:current_player)
        g.do_turn
      end

      it "randomly selects the first player" do
        allow_any_instance_of(Game).to receive(:first_turn?).and_return(true) 
        first_5 = []
        5.times{ first_5 << Game.new.current_player }

        next_5 = []
        5.times{ next_5 << Game.new.current_player }
        expect(first_5).not_to eq next_5
      end

      it "toggles between players" do 
        allow_any_instance_of(Game).to receive(:first_turn?).and_return(false)
        g = Game.new
        g.last_player = @player_x
        expect(g.current_player).not_to eq(@player_x)
      end



    end
  end
end