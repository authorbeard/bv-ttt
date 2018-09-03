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
  end
end