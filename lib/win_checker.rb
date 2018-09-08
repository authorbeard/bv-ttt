class WinChecker
  attr_reader :board, :winner, :draw, :eliminated

  def self.winner?(board)
    new(board).tap{|svc| svc.winner?}.winner
  end

  def self.draw?(board)
    new(board).tap{|svc| svc.draw?}.draw
  end

  def initialize(board)
    @board  = board
    @winner = nil
    @eliminated = {horiz: [], vert: [], diag: [] }
    @matches  = []
  end

  def winner?
    @winner = horizontal? || vertical? || diagonal?
  end

  def traverse(pos=nil, dir=nil)
    puts "matches: #{@matches}"
    @position = pos || 1
    @dir      = dir || next_adjacent.shift
    puts "checking #{@position}"
    if check
      while @matches.count < size
        shift_to_adj_vars
        traverse(@next, @dir)
      end
        @winner = player_at(@matches.last)
        return true
    else
      move
    end
  end


  def check
    if player_at(@position).nil?
      @eliminated[@dir] |= [send(@dir)]
      return false
    end 
    @next = next_pos
    @matches |= [@position, @next] if player_at(@position) == player_at(@next)
  end

  def move
    @eliminated[@dir] |= [send(@dir)]
    @dir = next_adjacent.shift
    if @dir.nil?
      @adj = nil
      @position += 1
    end
    @next, @last = nil, nil
    traverse(@position, @dir)
  end

  def shift_to_adj_vars
    @last, @position, @next = @position, @next, next_pos
  end

  def clear_for_move
    @position = @position + 1
    [@next, @last, @adj].map{|var| var = nil}
  end

  def next_pos
    next_step = step_size[@dir] || diag_step
    @position + next_step
  end

  def horiz
    board.row(@position)
  end

  def vert
    board.col(@position)
  end

  def diag
    diag_step
  end

  def diag_step
    if board.col(@position) == size
      size - 1
    else
      adj = @last ? (vert - board.col(@last)) : 1
      size + adj
    end
  end

  def should_continue?
    matches_possible? && board.valid_position?(@position)
  end

  # def horiz_eliminated?
  #   @eliminated[:horiz].include?(send(@dir))
  # end

  # def vert_eliminated?
  #   @eliminated[:vert].include?(send(@dir))
  # end

  # def diag_eliminated?
  #   if player_at(@position).nil?
  #     @eliminated[:diag] |= [diag_dir]
  #   else
  #     player_at(@position) != player_at(next_pos)
  #   end
  # end

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
    { horiz: 1, vert:  size }
  end

  def next_adjacent
    @adj ||= [:horiz, :vert, :diag]
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