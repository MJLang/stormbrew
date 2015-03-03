require 'rails_helper'

RSpec.describe Heroes::Versionable do
  it 'Finds the correct version of a game with matching data' do
    available_versions = [1, 3, 9, 18]
    current_version = 4
    object = Object.new
    object.extend(Heroes::Versionable)
    matching_version = object.determine_version(available_versions, current_version)
    expect(matching_version).to eq(3)
  end
end