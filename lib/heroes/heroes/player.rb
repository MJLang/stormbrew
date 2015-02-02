## Data Structure:

     # {0=>"TeeAych", - Player Name
     #  1=>{0=>1, 1=>"Hero", 2=>1, 4=>144731}, - Battle Net Info
     #  2=>"", - Not Used
     #  3=>{0=>255, 1=>35, 2=>35, 3=>35}, - Colors
     #  4=>2, - Player Type
     #  5=>1, - Team Number
     #  6=>100,
     #  7=>0,
     #  8=>1, -> Winner: 1, Looser: 2
     #  9=>9, - Player Number
     #  10=>"Azmodan"}], - Hero Name

module Heroes
  class Player
    attr_accessor :battleNetRegionId, :battleNetSubId, :battleNetId,
                  :color, :winner, :name, :battleTag, :player_type, :team, :handicap,
                  :auto_select, :character, :character_level, :talents


    def initialize(data, attributes = nil) 
      @name = data[0]
      @battleNetRegionid = data[1][0]
      @battleNetSubId = data[1][2]
      @battleNetId = data[1][4]
      @color = data[3].values
      @team = data[5]
      @handicap = data[6]
      @winner = data[8] == 1
      @character = data[10]
    end
  end 
end


