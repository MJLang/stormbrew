require 'bindata'
require_relative 'serialized_data'


module Heroes
  class Details < BinData::Record
    serialized_data :data
  end
end