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

  class AttributeEvents
    def self.parseAttributes(replay, attributes)
      attributes.each do |attribute|
        case attribute.id
        when 500
          if attribute.attribute_value.downcase == "humn"
            replay.players[attribute.player_number - 1].player_type = "Human"
          else
            replay.players[attribute.player_number - 1].player_type = "Computer"
          end
        when 4010
          if replay.game_mode != 'Custom'
            if attribute.attribute_value.downcase == 'drft'
              replay.game_mode = 'Hero League'
            else
              replay.game_mode = "Quick Match"
            end
          end
        end
      end
    end
  end
end