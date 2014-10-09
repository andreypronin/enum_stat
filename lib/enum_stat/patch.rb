module EnumStat
  DefaultClassesToPatch = [Enumerable, Enumerator, Array, Range, Set, Hash, NilClass]

  def self.patch_class(klass)
    patch_as_delegate(klass) || patch_with_module(klass)
  end
  
  def self.patch_classes(list = DefaultClassesToPatch)
    list.each { |klass| patch_class(klass) }
  end
end

EnumStat::patch_classes