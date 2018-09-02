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

  def move(position, player_piece)
    if valid_position?(position) && space_is_available(position)
      state[position] = player_piece
      state
    end
  end

  def valid_position?(position)
    state.keys.include?(position)
  end

  def space_is_available(position)
    state[position].empty?
  end
end