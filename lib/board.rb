class Board
  attr_accessor :state

  def initialize
    @state = empty_state
  end

  def empty_state 
    (0..8).to_a.each_with_object({}) do | position, board|
        board[position] = ""
    end
  end
end