require "spec_helper"

RSpec.describe "../lib/win_checker.rb" do 
  describe WinChecker do 
    before :each do 
      @board = Board.new
    end

      it "returns false for an empty board" do 
        expect(WinChecker.new(@board).winner?).to be_falsey
      end

      it "handles a messy board with a horizontal winner" do 
        @board = Board.new
        [4, 5, 6].each{|pos| @board.update_state(pos, "O")}
        [1, 3, 7].each{|pos| @board.update_state(pos, "X")}

        winner = WinChecker.new(@board).traverse
        expect(winner).to be_truthy
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
          winner = WinChecker.new(board_2).traverse
          expect(winner).to be_truthy
        end
      end

      it "returns false for an empty board" do 
        winner = WinChecker.new(@board).traverse
        expect(winner).to be_falsey
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
          winner = WinChecker.new(board_2).traverse
          expect(winner).to be_truthy
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
          winner = WinChecker.new(board_2).traverse
          expect(winner).to be_truthy
        end
      end

      it "handles a messy board with no winner" do 
        @board = Board.new
        [5, 3, 4].each{|pos| @board.update_state(pos, "O")}
        [1, 7].each{|pos| @board.update_state(pos, "X")}

        winner = WinChecker.new(@board).traverse
        expect(winner).to be_falsey
      end
  end
end