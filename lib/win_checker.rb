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
    @eliminated = {rows: [], cols: [], diags: []}
    @checked  = []
    @size   = board.size
  end

  def winner?
    @winner = horizontal? || vertical? || diagonal?
  end

  # def horizontal?
  #   winner = board.horizontal.detect{|row| match?(row) }
  #   winner.nil? ? false : board.player_at(winner.first)
  # end

  # def vertical?
  #   winner = board.vertical.detect{|row| match?(row) }
  #   winner.nil? ? false : board.player_at(winner.first)
  # end

  # def diagonal?
  #   winner = board.diagonal.detect{|diag| match?(diag) }
  #   winner.nil? ? false : board.player_at(winner.first)
  # end

  # def match?(positions)
  #   players  = positions.map{|pos| board.player_at(pos) }.uniq
  #   players.first.nil? ? false : players.length == 1
  # end

  # def draw?
  #   eliminated = ["horizontal", "vertical", "diagonal"].map do |type|
  #                   board.send(type).all? do |positions|
  #                     players  = positions.map{|pos| board.player_at(pos) }.uniq
  #                     players.compact.length > 1
  #                   end
  #                 end
  #   @draw = eliminated.all?{|result| result == true }
  # end

  def traverse(pos, dir = nil)
    @position = pos
    @dir      = dir || "horiz"
    reset_elim and return false unless should_continue?
    puts "checking #{@position}"

    if row_eliminated? && @dir == "horiz"
      if @eliminated[:rows].last == @size
        traverse(next_col, "vert")
      else
        traverse(next_row)
      end
    end

    if col_eliminated? && dir == "vert"
      if @eliminated[:cols].last == @size
        traverse(1, "diag")
      else
        traverse(next_col, "vert")
      end
    end

    if diag_eliminated? && dir == "diag"
      binding.pry
    end

    if end_of_row?
      binding.pry
      puts "end of row"
      if !@checked.empty? && @checked.uniq!.count == @size
        @winner = board.player_at(@checked.first)
        puts "Winner: #{@winner}"
        return true
      else
        @checked.clear
        puts "moving down"
        traverse(next_row, @size)
      end
    end

    if board.player_at(@position) == board.player_at(next_pos)
      binding.pry
      @checked << @position << next_pos
      traverse(next_pos, step_size[@dir])
    else
      @checked.clear if @checked
      puts "moving down"
      if pos < @size
        binding.pry
        traverse(next_row, step_size[@dir.to_sym])
      else
        binding.pry
      end
    end
  end

  def next_row
    row * @size + 1
  end

  def next_col
    col + 1
  end

  def next_pos
    next_step = step_size[@dir.to_sym] || step_size[diag.to_sym]
    @position + next_step
  end

  def row
    board.row(@position)
  end

  def col
    board.col(@position)
  end

  def diag
    board.diag(@position)
  end

  def l_diag
  end

  def end_of_row?
    @position % board.size == 0
  end

  def should_continue?
    handle_nil
    @winner.nil? && matches_possible? 
  end

  def handle_nil
    if board.player_at(@position).nil?
      @eliminated[:diags] << diag
      @eliminated[:rows]  << row
      @eliminated[:cols]  << col
      
      @eliminated.each{|k, v| v.uniq! }
    end
  end

  def row_eliminated?
    @eliminated[:rows].include?(row)
  end

  def col_eliminated?
    @eliminated[:cols].include?(row)
  end

  def diag_eliminated?
    @eliminated[:diags].include?(diag)
  end

  def matches_possible?
    @eliminated.none?{|k, v| v.count >= @size && v != :diags } || @eliminated[:diags].count < @size - 1
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
    @eliminated.each{|k, v| k.clear }
    @checked.clear
  end
end