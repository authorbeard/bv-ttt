class MoveService
  attr_accessor :board

  def self.make_move(board, position, player)
    board.valid_move?(position) && !!board.update_state(position, player.piece)
  end

  def self.valid_move?(position)
    board.valid_position?(position) && board.space_is_available?(position)
  end
end