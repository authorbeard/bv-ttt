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
    return false if @eliminated == board.positions
    move_over(position) if @eliminated.include?(position)
    move_down(position) if board.player_at(position).nil?
      if match?(position, position + 1)
        if match?(position, @prev_match)
          @winner = board.player_at(position)
          return true
        end
        @prev_match = position
        horiz_match(position + 1)
      end
  end

  def move_down(position)
    @eliminated += board.horizontal.select{|r| r.include?(position)}.flatten
    horiz_match(position + 3)
  end

  def move_over(position)
    horiz_match(position + 1)
  end

  def match?(position_1, position_2)
    players = [position_1, position_2].map{|pos| board.player_at(pos) }
    players.uniq.length == 1
  end


end