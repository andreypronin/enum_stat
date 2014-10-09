module EnumStat
  module EnumerableMethods
    def can_be_iterated?
      true
    end
    def sum
      EnumStat::numeric_a(self).reduce(0,:+)
    end
    def average
      return nil if count <= 0
      EnumStat::d_conv(sum)/count
    end
    def median
      if count == 0
        nil
      elsif count.odd?
        EnumStat::numeric_sort(self)[count/2]
      else
        EnumStat::numeric_sort(self)[(count-1)/2,2].average
      end
    end
    def percentile(p)
      return nil if count <= 0
      if index = EnumStat::percentile(p,0,count-1)
        EnumStat::numeric_sort(self)[ index.ceil ]
      end
    end
  end

  def self.enum_stat_methods
    EnumerableMethods.instance_methods # [:can_be_iterated?,:sum,:average,:median,...]
  end
  
  def self.patch_with_module(mod)
    mod.include EnumerableMethods
  end
end