module Heroes

  class Talent
    extend Versionable
    attr_accessor :name, :tier

    def initialize(args)
      args.each do |k, v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def self.parse_set(hero_name, talent_set, build)
      formated_hero_name = hero_name.downcase.gsub(/[^0-9a-z ]/i, '_')
      all_talents = YAML.load_file("#{__dir__}/talents/#{formated_hero_name}.yml")
      version = self.determine_version(all_talents.keys, build)
      versioned_talents = all_talents[version]
# 
      # talents = []
      talents = talent_set.map.with_index do |talent_id, index|
        talent_name = versioned_talents.values.flatten[talent_id]
        talent = Talent.new({name: talent_name, tier: index + 1})
      end
    end
  end
end