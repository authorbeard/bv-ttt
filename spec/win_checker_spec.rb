require "spec_helper"

RSpec.describe "../lib/win_checker.rb" do 
  describe WinChecker do 
    before :each do 
      @board = Board.new
    end

      it "returns false for an empty board" do 
        expect(WinChecker.new(@board).winner?).to be_falsey
      end

      it "handles a messy board with no winner" do 
        @board = Board.new
        [4, 5, 6].each{|pos| @board.update_state(pos, "O")}
        [0, 3, 7].each{|pos| @board.update_state(pos, "X")}

        svc = WinChecker.new(@board)
        expect(svc.winner?).to be_falsey
      end

      it "returns false with only a vertical winner" do 
        [4, 7, 1].each{|pos| @board.update_state(pos, "O")}
        [0, 3, 2].each{|pos| @board.update_state(pos, "X")}
        
        svc = WinChecker.new(@board)
        expect(svc.winner?).to be_falsey
      end

      it "returns true for a match on any line" do 
        horizontal = [
                       [1,2,3],
                       [4,5,6],
                       [7,8,9]
                      ]
        horizontal.each do |row|
          board_2 = Board.new
          row.each{|p| board_2.update_state(p, "O")}
          svc = WinChecker.new(board_2)
          expect(svc.winner?).to be_truthy
        end
      end

      it "returns false for an empty board" do 
        svc = WinChecker.new(@board)
        expect(svc.winner?).to be_falsey
      end

      it "handles a messy board with no winner" do 
        @board = Board.new
        [4, 5, 6].each{|pos| @board.update_state(pos, "O")}
        [0, 3, 7].each{|pos| @board.update_state(pos, "X")}

        svc = WinChecker.new(@board)
        expect(svc.winner?).to be_falsey
      end

      it "returns false with only a horizontal winner" do 
        [6, 7, 8].each{|pos| @board.update_state(pos, "O")}
        [0, 3, 2].each{|pos| @board.update_state(pos, "X")}
        
        svc = WinChecker.new(@board)
        expect(svc.winner?).to be_falsey
      end

      it "returns true for a match on any line" do 
        vertical = [
                     [1,4,7],
                     [2,5,8],
                     [3,6,9]
                   ]
        vertical.each do |row|
          board_2 = Board.new
          row.each{|p| board_2.update_state(p, "O")}
          svc = WinChecker.new(board_2)
          expect(svc.winner?).to be_truthy
        end
      end

      it "returns true for a match in any column" do 
        diagonal = [
                     [1,5,9],
                     [3,5,7]
                   ]
        diagonal.each do |row|
          board_2 = Board.new
          row.each{|p| board_2.update_state(p, "O")}
          svc = WinChecker.new(board_2)
          expect(svc.winner?).to be_truthy
        end
      end

      it "handles a messy board with no winner" do 
        @board = Board.new
        [4, 5, 6].each{|pos| @board.update_state(pos, "O")}
        [0, 3, 7].each{|pos| @board.update_state(pos, "X")}

        svc = WinChecker.new(@board)
        expect(svc.winner?).to be_falsey
      end

      it "returns false with only a horizontal winner" do 
        [6, 7, 8].each{|pos| @board.update_state(pos, "O")}
        [0, 3, 2].each{|pos| @board.update_state(pos, "X")}
        
        svc = WinChecker.new(@board)
        expect(svc.winner?).not_to be_truthy
      end
  end
end