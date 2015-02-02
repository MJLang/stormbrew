module MPQ
  class BlockEncryptor
    attr_accessor :key, :offset, :buffer, :size

    def initialize(key, offset, buffer, size)
      @key = key
      @offset = offset
      @buffer = buffer
      @size = size
    end

    def self.hash_string(key, offset)
      BlockEncryptor.new(key, offset, nil, nil).hash_string
    end

    def decrypt
      seed1 = hash_string
      seed2 = 0xEEEEEEEE
      result = ""
      size = @size

      while size >= 4
        seed2 += encryption_table[0x400 + (seed1 & 0xFF)]
        seed2 &= 0xFFFFFFFF

        value = buffer.readbytes(4).unpack("V").first
        value = (value ^ (seed1 + seed2)) & 0xFFFFFFFF

        result += [value].pack("V")

        seed1 = ((~seed1 << 0x15) + 0x11111111) | (seed1 >> 0x0B)
        seed1 &= 0xFFFFFFFF
        seed2 = value + seed2 + (seed2 << 5) + 3 & 0xFFFFFFFF
        size = size - 4
      end

      result
    end

    def encrypt
      seed1 = hash_string
      seed2 = 0xEEEEEEEE
      encrypted_block = []

      while @size >= 4
        seed2 += encryption_table[0x400 + (seed1 & 0xFF)]
        seed2 &= 0xFFFFFFFF

        value = buffer.readbytes(4).unpack("V").first
        value = (value ^ (seed1 + seed2)) & 0xFFFFFFFF

        encrypted_block << value

        seed = ((~seed1 << 0x15) + 0x11111111) | (seed1 >> 0x0B)
        seed2 = value + seed2 + (seed2 << 5) + 3 & 0xFFFFFFFF

        @size = @size - 4
      end

      encrypted_block.pack("V*")
    end

    def hash_string
      seed1 = 0x7FED7FED
      seed2 = 0xEEEEEEEE

      @key.upcase.each_byte do |char|
        value = encryption_table[@offset + char]
        seed1 = (value ^ (seed1 + seed2)) & 0xFFFFFFFF
        seed2 = char + seed1 + seed2 + (seed2 << 5) + 3 & 0xFFFFFFFF
      end

      seed1
    end

    private
    def encryption_table
      @encryption_table ||= begin
        crypt_buf = []
        seed = 0x00100001

        0.upto(0x100 - 1) do |index1|
          index2 = index1

          0.upto(4) do |i|
            seed = (seed * 125 + 3) % 0x2AAAAB
            temp1 = (seed & 0xFFFF) << 0x10

            seed = (seed * 125 + 3) % 0x2AAAAB
            temp2 = (seed & 0xFFFF)

            crypt_buf[index2] = (temp1 | temp2)

            index2 = index2 + 0x100
          end
        end

        crypt_buf
      end
    end

  end
end