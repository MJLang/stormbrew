module Heroes
  module Versionable
    def determine_version(possible_versions, actual_version)
      return possible_versions.first if possible_versions.length == 1
      current_index = 0
      matching = false
      until matching do

        low_end = possible_versions[current_index]
        high_end = possible_versions[current_index += 1]  || low_end
        matching = actual_version.between?(low_end, high_end)
      end

      possible_versions[current_index - 1]
    end
  end
end
