class WinChecker
  attr_reader :board

  def self.winner?(board)
    new(board).tap{|svc| svc.winner?}
  end

  def self.draw?(board)

  end

  def initialize(board)
    @board = board
  end

  def winner?
    horizontal? || vertical? || diagonal?
  end

  def horizontal?

  end

  def vertical?

  end

  def diagonal?

  end

end