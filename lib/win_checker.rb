class WinChecker
  attr_reader :board, :winner, :prev_match

  def self.winner?(board)
    new(board).tap{|svc| svc.winner?}
  end

  def self.draw?(board)

  end

  def initialize(board)
    @board      = board
    @eliminated = board.open_spaces.keys
    @winner     = nil
    @prev_match = nil
  end

  def winner?
    if horizontal? || vertical? || diagonal?
      @winner
    end
  end

  def horizontal?
    horiz_match(0)
  end

  def vertical?

  end

  def diagonal?

  end

  def horiz_match(position)
    return true if @winner
    return false unless board.valid_position?(position) 
    return false if @eliminated.uniq.count == board.positions.count
    move_down(position) if board.player_at(position).nil?
    move_over(position) if @eliminated.include?(position)


    if row_match?(position) 
      @winner = board.player_at(position)
      return true
    else
      move_down(position)
    end
  end

  def move_down(position)
    @eliminated += board.horizontals.select{|r| r.include?(position)}.flatten
    horiz_match(position + 3)
  end

  def move_over(position)
    horiz_match(position + 1)
  end

  def row_match?(position)
    row     = board.horizontals.select{|r| r.include?(position) }.flatten
    players = row.map{|pos| board.player_at(pos) }
    players.uniq.length == 1
  end
end