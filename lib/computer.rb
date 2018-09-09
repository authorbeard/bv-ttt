class Computer < Player
  def initialize(params={})
    super
    @name = "Computer"
    @comms = CommunicatorService.new
  end

  def choose_move(board)
    dumb_computer(board)
  end

  def dumb_computer(board)
    pos = board.open_spaces.first
    puts @comms.computer_turn(pos)
    sleep 1
    pos
  end
end