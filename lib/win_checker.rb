class WinChecker
  attr_reader :board, :winner, :draw

  def self.winner?(board)
    new(board).tap{|svc| svc.winner?}.winner
  end

  def self.draw?(board)
    new(board).tap{|svc| svc.draw?}.draw
  end

  def initialize(board)
    @board      = board
    @winner     = nil
  end

  def winner?
    @winner = horizontal? || vertical? || diagonal?
  end

  def horizontal?
    winner = board.horizontal.detect{|row| match?(row) }
    winner.nil? ? false : board.player_at(winner.first)
  end

  def vertical?
    winner = board.vertical.detect{|row| match?(row) }
    winner.nil? ? false : board.player_at(winner.first)
  end

  def diagonal?
    winner = board.diagonal.detect{|diag| match?(diag) }
    winner.nil? ? false : board.player_at(winner.first)
  end

  def match?(positions)
    players  = positions.map{|pos| board.player_at(pos) }.uniq
    players.first.nil? ? false : players.length == 1
  end

  def draw?
    eliminated = ["horizontal", "vertical", "diagonal"].map do |type|
                    board.send(type).all? do |positions|
                      players  = positions.map{|pos| board.player_at(pos) }.uniq
                      players.compact.length > 1
                    end
                  end
    @draw = eliminated.all?{|result| result == true }
  end
end