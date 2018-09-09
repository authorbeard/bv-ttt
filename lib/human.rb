class Human < Player
  def initialize(params={})
    super
  end

  def choose_move(board)
    STDIN.gets.strip.to_i
  end
end