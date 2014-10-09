module EnumStat
  DelegationCases = { NilClass => [], Hash => :values }

  def self.delegate_enum_stat(mod)
    obj = DelegationCases[mod]
    enum_stat_methods.each do |mname|
      mod.class_eval do
        obj.is_a?(Symbol) ?
          define_method(mname) { |*args| send(obj).send(mname,*args) } :
          define_method(mname) { |*args| obj.send(mname,*args) }
      end
    end
    true
  end
  
  def self.patch_as_delegate(mod)
    delegate_enum_stat(mod) if DelegationCases.include?(mod)
  end
end