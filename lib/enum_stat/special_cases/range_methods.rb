module EnumStat
  module RangeMethods
    def can_be_iterated?
      self.begin.respond_to?(:succ)
    end
    def sum
      return super if can_be_iterated?
      Float::INFINITY
    end
    def average
      return super if can_be_iterated?
      [self.begin,self.end].average
    end
    def median
      return super if can_be_iterated?
      average
    end
    def percentile(p)
      return super if can_be_iterated?
      EnumStat::percentile(p,self.begin,self.end)
    end
  end
end