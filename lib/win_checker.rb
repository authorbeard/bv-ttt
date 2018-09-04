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
    @dir = "horizontal"
    traverse(0)
  end

  def vertical?
    @dir = "vertical"
    traverse(0)
  end

  def diagonal?

  end

  def traverse(position)
    return true if @winner
    return false unless continue?(position)
    send("eliminate_#{@dir}", position) if board.player_at(position).nil?
    next_position(position) if @eliminated.include?(position)

    if match?(position) 
      @winner = board.player_at(position)
      return true
    else
      send("eliminate_#{@dir}", position)
    end
  end

  def eliminate_horizontal(position)
    @eliminated += board.horizontal.select{|r| r.include?(position)}.flatten
    traverse(position + 3)
  end

  def eliminate_vertical(position)
    @eliminated += board.vertical.select{|r| r.include?(position)}.flatten
    traverse(position + 1)
  end

  def next_position(position)
    step = steps[@dir]
    traverse(position + step)
  end

  def match?(position)
    matchset = board.send(@dir).select{|r| r.include?(position) }.flatten
    players  = matchset.map{|pos| board.player_at(pos) }
    players.uniq.length == 1
  end

  def continue?(position)
    board.valid_position?(position) && @eliminated.uniq.count != board.positions.count
  end

  def steps
    {
      "horizontal" => 1,
      "vertical"   => 3, 
      "diagonal"   => 4
    }.freeze
  end
end