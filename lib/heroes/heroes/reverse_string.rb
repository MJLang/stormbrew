require 'bindata'

module Heroes
  class ReverseString < BinData::String
    mandatory_parameters :read_length

    def read_and_return_value(io)
      super.reverse.gsub("\x00", '')
    end

    def value_to_binary_string(value)
      clamp_to_length(val.reverse)
    end
  end
end