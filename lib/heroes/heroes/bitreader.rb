module Heroes
  class BitReader
    attr_accessor :stream, :cursor, :current_byte

    def initialize(stream)
      @stream = stream
      @cursor = 0
    end

    def end?
      @stream.eof?
    end

    def read(number_of_bits)
      if (number_of_bits > 32)
        raise Error
      end
      value = 0
      while number_of_bits > 0
        byte_pos = @cursor & 7
        bits_left_in_byte = 8 - byte_pos
        if byte_pos == 0 then
          @current_byte = @stream.getbyte
        end
        bits_to_read = (bits_left_in_byte > number_of_bits) ? number_of_bits : bits_left_in_byte
        value = (value << bits_to_read) | (@current_byte >> byte_pos) & ((1 << bits_to_read) - 1)
        @cursor += bits_to_read
        number_of_bits -= bits_to_read
      end
      return value
    end

    def align_to_byte
      if (@cursor & 7) > 0
        @cursor = (@cursor & 0x7ffffff8) + 8
      end
    end

    def unaligned?
      (@cursor & 7) > 0
    end

    def read_bytes(bytes)
      byte_array = []
      bytes.times do
        byte_array << @stream.getbyte
      end
      return byte_array
    end
    def read_string(bit_length)

    end

    def read_boolean()
      self.read(1) == 1
    end

    def read_blob_with_length(num_bits_for_length)
      string_length = self.read(num_bits_for_length)
      self.align_to_byte
      return read_bytes(string_length)
    end
  end
end