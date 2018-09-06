class Board
  attr_accessor :state, :size

  def initialize(size = 3)
    @size = size
    @state = empty_state
  end

  def empty_state 
    (1..@size**2).to_a.each_with_object({}) do | position, board|
        board[position] = nil
    end
  end

  def positions
    @positions ||= state.keys
  end

  def update_state(position, player_piece)
    state[position] = player_piece
  end

  def valid_move?(position)
    valid_position?(position) && space_is_available?(position)
  end

  def valid_position?(position)
    state.member?(position)
  end

  def space_is_available?(position)
    state[position].nil?
  end

  def open_spaces
    state.select{|position, piece| piece.nil? }
  end

  def taken_spaces
    state.select{|position, piece| !!piece }
  end

  def player_at(position) 
    state[position]
  end

  def row(position)
    float = (position / size.to_f)
    position < size ? float.floor + 1 : float.ceil
  end

  def col(position)
    mod = position % size
    mod == 0 ? size : mod
  end

  def diag(position)
    side = position % size
    if [1, 0].include?(side)
      side == 0 ? "l_diag" : "r_diag"
    else
      nil
    end
  end
end