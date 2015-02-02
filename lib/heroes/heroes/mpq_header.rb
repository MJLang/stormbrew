require 'bindata'

module Heroes
  class MPQHeader < BinData::Record
    endian :little

    string :header, :read_length => 4
    uint32 :build
  end
end