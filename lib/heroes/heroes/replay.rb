module Heroes
  class Replay
    attr_accessor :mpq, :header, :details, :attributes, :players, 
                  :map, :timestamp, :version, :build,
                  :game_mode

    def initialize(filename, data=nil)
      self.mpq = MPQ::MPQ.read(data.nil? ? File.read(filename) : data)
      mpq_header = Details.read(self.mpq[:user_data])

      self.version = "%{main}.%{major}.%{minor}.%{sub}" % {
                                                            main: mpq_header.data[1][0],
                                                            major: mpq_header.data[1][1],
                                                            minor: mpq_header.data[1][2],
                                                            sub: mpq_header.data[1][3]
                                                          }
      self.build = mpq_header.data[1][4]
      self.attributes = Attributes.read(self.mpq.read_file('replay.attributes.events'))
      self.details = Details.read(self.mpq.read_file('replay.details'))
      self.map = self.details.data[1]
      self.players = self.details.data[0].map { |p| Heroes::Player.new(p) }
      self.timestamp = Time.from_wtime(self.details.data[5])
      GameAttributes.parseAttributes(self, self.attributes.attributes)
    end
  end
end