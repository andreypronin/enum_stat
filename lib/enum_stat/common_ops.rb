module EnumStat
  def self.d_conv(num) # convert for division
    case num
    when Fixnum, Bignum, String then num.to_f
    when Float, Complex, Rational then num
    when nil then 0
    else (num.to_f rescue 0)
    end
  end
  def self.a_conv(num) # convert for addition
    case num
    when Numeric then num
    when String then num.to_f
    when nil then 0
    else (num.to_f rescue 0)
    end
  end
  def self.n_rank(num) # convert for sorting
    case num
    when Complex then num.abs * (num.real > 0 ? 1 : -1)
    else a_conv(num)
    end
  end
  def self.percentile(p,b,e)
    p = a_conv(p)
    return nil if (p<0) || (p>1)
    b = a_conv(b)
    e = a_conv(e)
    b+p*(e-b)
  end
  
  def self.numeric_a(a) # convert to Array of numerics ready for addition
    a.map { |x| a_conv(x) }
  end
  def self.numeric_sort(a) # convert to *sorted* Array of numerics ready for addition
    numeric_a(a).sort_by { |x| n_rank(x) }
  end
end