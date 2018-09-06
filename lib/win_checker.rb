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
    @eliminated = {horiz: [], vert: [], diag: []}
    @checked  = []
    @size   = board.size
  end

  def winner?
    @winner = horizontal? || vertical? || diagonal?
  end

  def traverse(pos=nil, dir=nil)
    @position = pos || 1
    @dir      = dir || "horiz"
    reset and return false unless should_continue?
    puts "checking #{@position}"

    if horiz_eliminated? && @dir == "horiz"
      if @eliminated[:horiz].last == @size
        traverse(next_col, "vert")
      else
        traverse(next_row)
      end
    end

    if vert_eliminated? && dir == "vert"
      if @eliminated[:vert].last == @size
        traverse(1, "diag")
      else
        traverse(next_col, "vert")
      end
    end

    if diag_eliminated? && dir == "diag"
      other_diag = diag == "l_diag" ? "r_diag" : "l_diag"
      if @eliminated[:diag].include?(other_diag)
        return false
      else
        binding.pry
        traverse(@size, "diag")
      end
    end

    if end_of_row?
      puts "end of row"
      if !@checked.empty? && @checked.uniq.count == @size
        @winner = board.player_at(@checked.first)
        puts "Winner: #{@winner}"
        return true
      else
        exit
        @checked.clear
        puts "moving down"
        traverse(next_row, @dir)
      end
    end

    if end_of_col?
      puts "end of col"
      if !@checked.empty? && @checked.uniq.count == @size
        @winner = board.player_at(@checked.first)
        puts "Winner: #{@winner}"
        return true
      else
        @eliminated[@dir.to_sym] << send(@dir)
        @checked.clear
        puts "moving down"
        traverse(next_pos, @dir)
      end
    end


    if board.player_at(@position) == board.player_at(next_pos)
      @checked << @position << next_pos
      traverse(next_pos, step_size[@dir])
    else
      @checked.clear if @checked
      puts "moving down"
      traverse(next_row, @dir)
    end
  end

  def next_row
    horiz * @size + 1
  end

  def next_col
    vert + 1
  end

  def next_pos
    next_step = step_size[@dir.to_sym] || step_size[diag.to_sym] if diag
    if next_step.nil?
      binding.pry
    end
    @position + next_step 
  end

  def horiz
    board.row(@position)
  end

  def vert
    board.col(@position)
  end

  def diag
    board.diag(@position)
  end

  def end_of_row?
    vert == @size
  end

  def end_of_col?
    horiz == @size
  end

  def should_continue?
    handle_nil
    @winner.nil? && matches_possible? && board.valid_position?(@position)
  end

  def handle_nil
    if board.player_at(@position).nil?
      @eliminated[:diag] << diag if diag
      @eliminated[:horiz] << horiz
      @eliminated[:vert]  << vert
      
      @eliminated.each{|k, v| v.uniq! }
    end
  end

  def horiz_eliminated?
    @eliminated[:horiz].include?(send(@dir))
  end

  def vert_eliminated?
    @eliminated[:vert].include?(send(@dir))
  end

  def diag_eliminated?
    @eliminated[:diag].include?(diag) if diag
  end

  def matches_possible?
    @eliminated.none?{|k, v| v.count >= @size && v != :diag } || @eliminated[:diag].count < @size - 1
  end

  def step_size
    {
      horiz:  1,
      vert:   3,
      r_diag: @size + 1,
      l_diag: @size - 1 
    }
  end

  def reset
    @eliminated.each{|k, v| v.clear }
    @checked.clear
  end
end