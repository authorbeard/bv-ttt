require "spec_helper"

RSpec.describe "../lib/win_checker.rb" do 
  describe WinChecker do 
    before :each do 
      @board = Board.new
    end

    describe "#win" do 
      it "checks for a horizontal win" do
        expect_any_instance_of(WinChecker).to receive(:horizontal?)
        WinChecker.winner?(@board)
      end

      it "checks for a vertical win if there's no horizonal win" do 
        expect_any_instance_of(WinChecker).to receive(:vertical?)
        WinChecker.winner?(@board)
      end

      it "checks for a diagonal win if there's no other kind" do 
        expect_any_instance_of(WinChecker).to receive(:diagonal?)
        WinChecker.winner?(@board)
      end
    end

    describe "#horizontal?" do 
      before :each do 
        @rows = [ 
                  [0, 1, 2], 
                  [3, 4, 5],
                  [6, 7, 8]
                ]
      end

      it "returns true when all horizontal spaces are taken by the same player" do 
        @rows.first.each{|space| @board.update_state(space, "X")}
        svc = WinChecker.new(@board)
        expect(svc.horizontal?).to be true

        board_2 = Board.new
        @rows[1].each{|space| board_2.update_state(space, "X")}
        svc = WinChecker.new(@board)
        expect(svc.horizontal?).to be true

        board_3 = Board.new
        @rows.last.each{|space| board_3.update_state(space, "X")}
        svc = WinChecker.new(@board)
        expect(svc.horizontal?).to be true
      end

      it "returns false for an empty board" do 
        expect(WinChecker.new(@board).horizontal?).to be false
      end

      it "returns false when there are no matches" do
          @board.update_state(1, "X")
          svc = WinChecker.new(@board)
          expect(svc.horizontal?).to be false
      end

      it "handles a messy board with no winner" do 
        @board = Board.new
        [4, 5, 6].each{|pos| @board.update_state(pos, "O")}
        [0, 3, 7].each{|pos| @board.update_state(pos, "X")}

        svc = WinChecker.new(@board)
        expect(svc.horizontal?).to be false
      end

      it "returns false with only a vertical winner" do 
        [4, 7, 1].each{|pos| @board.update_state(pos, "O")}
        [0, 3, 2].each{|pos| @board.update_state(pos, "X")}
        
        svc = WinChecker.new(@board)
        expect(svc.horizontal?).to be false
      end

      it "returns true for a match on any line" do 
        horizontals = @board.horizontals
        horizontals.each do |row|
          board_2 = Board.new
          row.each{|p| board_2.update_state(p, "O")}
          svc = WinChecker.new(board_2)
          expect(svc.horizontal?).to be true
        end
      end
    end

    describe "#vertical?" do 
      it "returns false for an empty board" do 
        svc = WinChecker.new(@board)
        expect(svc.vertical?).to be false
      end

      it "returns true for a match in any column" do 
        verticals = @board.verticals
        verticals.each do |row|
          board_2 = Board.new
          row.each{|p| board_2.update_state(p, "O")}
          svc = WinChecker.new(board_2)
          expect(svc.horizontal?).to be true
        end
      end

    end
  end
end