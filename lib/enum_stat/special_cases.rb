require "enum_stat/special_cases/range_methods"

module EnumStat
  SpecialCases = { Range => RangeMethods }

  module EnumerableMethods
    def self.included(parent)
      if mod = EnumStat::SpecialCases[parent]
        parent.include mod
      end
    end
  end
end