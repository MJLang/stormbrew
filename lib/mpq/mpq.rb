require 'bindata'

require_relative 'mpq/archive_size'
require_relative 'mpq/archive_header'
require_relative 'mpq/sector'
require_relative 'mpq/file_data'
require_relative 'mpq/block_table'
require_relative 'mpq/hash_table'
require_relative 'mpq/block_encryptor'

module MPQ
  class MPQ < BinData::Record

    endian :little

    string :user_magic, :length => 4
    uint32 :user_data_max_length
    uint32 :archive_header_offset
    uint32 :user_data_length
    string :user_data, :length => :user_data_length

    archive_header :archive_header, :adjust_offset => lambda { archive_header_offset }
    encrypted_block_table :block_table, :entries => lambda { archive_header.block_table_entries },
                                        :adjust_offset => lambda { archive_header_offset + archive_header.block_table_offset }
    encrypted_hash_table  :hash_table,  :entries => lambda { archive_header.hash_table_entries },
                                        :adjust_offset => lambda { archive_header_offset + archive_header.hash_table_offset },
                                        :compressed => lambda { archive_header.block_table_offset != archive_header.hash_table_offset + archive_header.hash_table_entries * 16 }
    file_data_array :file_data,         :blocks => lambda { block_table.blocks },
                                        :sector_size_shift => lambda { archive_header.sector_size_shift },
                 
                                        :archive_header_offset => :archive_header_offset

    def files
      @files ||= read_file('(listfile)').split
    end

    def read_file(filename)
      ht_entry = get_hash_table_entry(filename)
      ht_entry.decompressed_data
    end

    def read_raw(filename)
      ht_entry = get_hash_table_entry(filename)
      ht_entry.get_file_data
    end

    def get_hash_table_entry(filename)
      hash_a = BlockEncryptor.hash_string(filename, 0x100)
      hash_b = BlockEncryptor.hash_string(filename, 0x200)

      block = self.block_table.blocks[self.hash_table.hashes.select {|hash| hash.file_path_hash_a == hash_a && hash.file_path_hash_b == hash_b}.first.file_block_index]
      result = self.file_data.select {|f| f.block_offset == block.block_offset}.first
    end
  end
end