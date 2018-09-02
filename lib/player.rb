class Player
  attr_accessor :name, :piece

  def initialize(params={})
    @piece = params[:piece] || "X"
    @name  = params[:name] || "Player #{@piece}"
  end
end