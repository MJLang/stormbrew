# require_relative 'heroes/replay'
# require_relative 'heroes/details'
# require_relative 'heroes/attributes'
# require_relative 'heroes/player'
# require_relative 'heroes/serialized_data'
# require_relative 'heroes/reverse_string'
# require_relative 'heroes/game_events'
# require_relative 'heroes/bitreader'
# require_relative 'heroes/details/talents'
# require_relative 'heroes/concerns/versionable'

Dir.glob(__dir__ + '/**/*.rb') { |f| require_relative f }

module Heroes

end
