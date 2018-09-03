class WinChecker
  attr_reader :board, :winner, :potential_winner

  def self.winner?(board)
    new(board).tap{|svc| svc.winner?}
  end

  def self.draw?(board)

  end

  def initialize(board)
    @board      = board
    @eliminated = board.open_spaces
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
    return false unless board.valid_position?(position) 
    move_down(position) if board.player_at(position).nil?
    return false if @eliminated.include?(position)
    return false if @eliminated == board.positions


      if board.player_at(position) == board.player_at(position + 1)
        @potential_winner = board.player_at(position)
        horiz_match(position + 1) 
        @winner = board.player_at(position)
        return true
      end
  end

  def move_down(position)
    @eliminated += board.horizontal.select{|r| r.include?(position)}.flatten
    horiz_match(position + 3)
  end


end