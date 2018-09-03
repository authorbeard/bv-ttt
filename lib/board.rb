class Board
  attr_accessor :state

  def initialize
    @state = empty_state
  end

  def empty_state 
    (0..8).to_a.each_with_object({}) do | position, board|
        board[position] = nil
    end
  end

  def positions
    @positions ||= state.keys
  end

  def update_state(position, player_piece)
      state[position] = player_piece
  end

  def valid_position?(position)
    positions.include?(position)
  end

  def space_is_available?(position)
    state[position].nil?
  end

  def open_spaces
    state.values.select(&:nil?)
  end

  def taken_spaces
    state.values.select{|s| !s.nil? }
  end

  def player_at(position) 
    state[position]
  end

  def horizontal
    [ 
      [0, 1, 2],
      [3, 4, 5], 
      [6, 7, 8] 
    ]
  end
end