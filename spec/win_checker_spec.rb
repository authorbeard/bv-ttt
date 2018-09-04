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
        horizontal = @board.horizontal
        horizontal.each do |row|
          board_2 = Board.new
          row.each{|p| board_2.update_state(p, "O")}
          svc = WinChecker.new(board_2)
          expect(svc.horizontal?).to be_truthy
        end
      end
    end

    describe "#vertical?" do 
      it "returns false for an empty board" do 
        svc = WinChecker.new(@board)
        expect(svc.vertical?).to be false
      end

      it "returns true for a match in any column" do 
        vertical = @board.vertical
        vertical.each do |row|
          board_2 = Board.new
          row.each{|p| board_2.update_state(p, "O")}
          svc = WinChecker.new(board_2)
          expect(svc.vertical?).to be_truthy
        end
      end

      it "returns false when there are no matches" do
          @board.update_state(1, "X")
          svc = WinChecker.new(@board)
          expect(svc.vertical?).to be false
      end

      it "handles a messy board with no winner" do 
        @board = Board.new
        [4, 5, 6].each{|pos| @board.update_state(pos, "O")}
        [0, 3, 7].each{|pos| @board.update_state(pos, "X")}

        svc = WinChecker.new(@board)
        expect(svc.vertical?).to be false
      end

      it "returns false with only a horizontal winner" do 
        [6, 7, 8].each{|pos| @board.update_state(pos, "O")}
        [0, 3, 2].each{|pos| @board.update_state(pos, "X")}
        
        svc = WinChecker.new(@board)
        expect(svc.vertical?).to be false
      end

      it "returns true for a match on any line" do 
        vertical = @board.vertical
        vertical.each do |row|
          board_2 = Board.new
          row.each{|p| board_2.update_state(p, "O")}
          svc = WinChecker.new(board_2)
          expect(svc.vertical?).to be_truthy
        end
      end
    end

    describe "#diagonal?" do 
      it "returns false for an empty board" do 
        svc = WinChecker.new(@board)
        expect(svc.diagonal?).to be false
      end

      it "returns true for a match in any column" do 
        diagonal = @board.diagonal
        diagonal.each do |row|
          board_2 = Board.new
          row.each{|p| board_2.update_state(p, "O")}
          svc = WinChecker.new(board_2)
          expect(svc.diagonal?).to be_truthy
        end
      end

      it "returns false when there are no matches" do
          @board.update_state(1, "X")
          svc = WinChecker.new(@board)
          expect(svc.diagonal?).to be false
      end

      it "handles a messy board with no winner" do 
        @board = Board.new
        [4, 5, 6].each{|pos| @board.update_state(pos, "O")}
        [0, 3, 7].each{|pos| @board.update_state(pos, "X")}

        svc = WinChecker.new(@board)
        expect(svc.diagonal?).to be false
      end

      it "returns false with only a horizontal winner" do 
        [6, 7, 8].each{|pos| @board.update_state(pos, "O")}
        [0, 3, 2].each{|pos| @board.update_state(pos, "X")}
        
        svc = WinChecker.new(@board)
        expect(svc.diagonal?).to be false
      end

      it "returns true for a match on any line" do 
        diagonal = @board.diagonal
        diagonal.each do |row|
          board_2 = Board.new
          row.each{|p| board_2.update_state(p, "O")}
          svc = WinChecker.new(board_2)
          expect(svc.diagonal?).to be_truthy
        end
      end
    end
  end
end