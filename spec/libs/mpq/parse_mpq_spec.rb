require 'rails_helper'

RSpec.describe MPQ, type: :lib do

  it "should be able to return the files contained in the container" do
    filePath = Rails.root.join("spec/support/dragon_shrine.StormReplay")
    file = File.read(filePath)
    mpq = MPQ::MPQ.read(file)

    expect(mpq.files.count).to be(12)
  end

end