require_relative 'reverse_string'

module Heroes
  class Attribute < BinData::Record
    endian :little

    string :header, :read_length => 4, :check_value => "\xE7\x03\x00\x00"
    uint32 :id
    uint8 :player_number
    reverse_string :attribute_value, :read_length => 4
  end

  class Attributes < BinData::Record
    endian :little

    skip :length => 5
    uint32 :num_attributes

    array :attributes, :type => :attribute, :initial_length => :num_attributes
  end

  class GameAttributes
    def self.parseAttributes(replay, attributes)
      attributes.each do |attribute|
        case attribute.id
        when 500 # Player Type
          if attribute.attribute_value.downcase == "humn"
            replay.players[attribute.player_number - 1].player_type = "Human"
          else
            replay.players[attribute.player_number - 1].player_type = "Computer"
          end

        when 3009 # Game Type
          game_type = attribute.attribute_value
          case game_type.downcase
          when 'priv'
            replay.game_mode = 'Custom'
          when 'amm'
            if replay.build < 33684
              replay.game_mode = 'Quick Match'
            end
          end

        when 4002 # Auto Select
          replay.players[attribute.player_number - 1].auto_select = attribute.attribute_value.downcase == 'rand'

        when 4008 # Char Level
          char_level = attribute.attribute_value.to_i
          player = replay.players[attribute.player_number - 1]
          if player
            player.character_level = char_level
          end

        when 4010 # Picking Mode
          if replay.game_mode != 'Custom'
            case attribute.attribute_value.downcase
            when 'drft'
              replay.game_mode = 'Heroe League'
            when 'stan'
              replay.game_mode = "Quick Match"
            end
          end
        end
      end
    end
  end
end