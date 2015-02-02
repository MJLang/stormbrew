require 'rails_helper'
# require 'lib/mpq'

RSpec.describe Heroes do

  before :each do 
    versus_file_path = Rails.root.join("spec/support/dragon_shrine.StormReplay")
    @versus_file = File.open(versus_file_path)
    @versus_replay = Heroes::Replay.new(@versus_file)
  end

  describe Heroes::Replay do
    it "should have 10 players" do
      expect(@versus_replay.players.count).to be(10)
    end

    describe 'Versus' do
    end
  end

  describe Heroes::Player do
    let (:winning_player) { @versus_replay.players[5] }
    let (:loosing_player) { @versus_replay.players[2] }

    it "should have a player name" do
      expect(winning_player.name).to eq("Celthorne")
    end

    it "should have a hero name" do
      expect(winning_player.character).to eq("Arthas")
    end

    it "should have a battleNetId" do
      expect(winning_player.battleNetId).to eq(251258)
    end
  end
end