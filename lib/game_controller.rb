class GameController
  attr_accessor :game, :comms

  def self.start
    new.tap.start
  end

  def new
    @comms = CommunicatorService.new
  end

  def start
    @coms.main_menu
  end
end