class WinChecker
  attr_reader :board, :winner, :draw, :eliminated

  def self.winner?(board)
    new(board).tap{|svc| svc.winner?}.traverse
  end

  def initialize(board)
    @board  = board
    @winner = nil
    @eliminated = {row: [], col: [], diag: [] }
    @matches  = []
  end

  def traverse(pos=nil, dir=nil)
    @position = pos || 1
    @dir      = dir || next_adjacent.shift

    if check
      if @winner
        return @winner
      else
        shift_to_adj_vars
        traverse(@position, @dir)
      end
    else
      @matches.clear
      move
    end
  end

  def check
    return false unless should_continue? && avail?
    @next = next_pos
    if player_at(@position).nil?
      @eliminated[@dir] |= [send(@dir)]
      return false
    end
    if player_at(@position) == player_at(@next) && board.valid_position?(@next)
      @matches |= [@position, @next]
      winner? || true
    end
  end

  def move
    return false unless should_continue? 
    @eliminated[@dir] |= [send(@dir)]
    @dir = next_adjacent.shift
    if @dir.nil?
      @adj = nil
      if board.valid_position?(@position + 1) 
        @position += 1 
      else 
        @position = 2
      end
    end
    @next, @last = nil, nil
    traverse(@position, @dir)
  end

  def winner?
    @winner = @matches.count == @size ? player_at(@matches.first) : nil
  end

  def shift_to_adj_vars
    @last, @position = @position, @next
    @next = next_pos
  end

  def clear_for_move
    @position = @position + 1
    [@next, @last, @adj].map{|var| var = nil}
  end

  def prev_pos
    next_step = step_size[@dir] || diag_step
    @position - next_step
  end

  def next_pos
    next_step = step_size[@dir] || diag_step
    @position + next_step 
  end

  def row
    board.row(@position)
  end

  def col
    board.col(@position)
  end

  def diag
    diag_step
  end

  def diag_step
    if board.col(@position) == size
      size - 1
    else
      adj = @last ? (col - board.col(@last)) : 1
      size + adj
    end
  end

  def should_continue?
    matches_possible? && board.valid_position?(@position)
  end

  def avail?
    true if @dir.nil?
    !@eliminated[@dir].include?(send(@dir))
  end

  def matches_possible?
    @eliminated.any? do |k, v| 
      if k == :diag
        v.count < 2
      else
        v.count < size 
      end
    end
  end

  def step_size
    { row: 1, col:  size }
  end

  def next_adjacent
    @adj ||= [:row, :col, :diag]
  end

  def reset
    @eliminated.each{|k, v| v.clear }
    @matches.clear
  end

  def player_at(position)
    board.player_at(position)
  end

  def size
    @size ||= board.size
  end
end