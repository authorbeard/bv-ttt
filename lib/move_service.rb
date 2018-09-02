class MoveService
  attr_accessor :board

  def initialize(board=nil)
    @board = board || Board.new
  end

  def make_move(position, player)
    valid_move?(position) && !!board.update_state(position, player.piece)
  end

  def valid_move?(position)
    board.valid_position?(position) && board.space_is_available?(position)
  end
end