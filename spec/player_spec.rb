require "spec_helper"

RSpec.describe "../lib/player.rb" do 
  describe Player do 
    it "can be initialized with only a name" do 
      player = Player.new(name: "custom name")
      expect(player.name).to eq "custom name"
      expect(player.piece).not_to be nil
    end

    it "can be initialized with only a custom game piece" do 
      player = Player.new(piece: "Z")
      expect(player.piece).to eq "Z"
      expect(player.name).to eq "Player Z"
    end
  end
end