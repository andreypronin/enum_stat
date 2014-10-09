require 'spec_helper'

RSpec.describe "A enumerable list" do
  it "has EnumStat methods" do
    test_class = Class.new do
      include Enumerable
      def each; end
    end
    sample_method = :average
    sample_objects = [ test_class.new, Set.new, Array.new, Hash.new, Range.new(0,1) ]
    
    sample_objects.each do |sample_obj|
      expect( sample_obj ).to respond_to(sample_method)
      expect{ sample_obj.send(sample_method) }.not_to raise_exception
    end
  end
  
  it "can be nil" do
    sample_method = :average
    expect( nil ).to respond_to(sample_method)
    expect{ nil.send(sample_method) }.not_to raise_exception
  end
  
  it "recognizes non-iterateable ranges" do
    verify_examples :can_be_iterated?, 
    [
      { input: nil, output: true },
      { input: [], output: true },
      { input: [17], output: true },
      { input: ["2",nil,"3.2",7], output: true },
      { input: [3*Math::PI,Math::PI], output: true },
      { input: [3,2,1], output: true },
      { input: {5=>3,10=>2,"a"=>1}, output: true },
      { input: Set[3,2,1], output: true },
      { input: [2,1], output: true },
      { input: (1..2), output: true },
      { input: (1...3), output: true },
      { input: (1..2.5), output: true },
      { input: (0.5..0.7), output: false },
      { input: (0.5..0.7).step(0.1), output: true },
      { input: (0.5..0.7).step(0.15), output: true },
      { input: (2/3.to_r..5/3.to_r), output: false }, 
      { input: (2/3.to_r..5/3.to_r).step(1/3.to_r), output: true }, 
      # Range doesn't support Complex
    ]
  end

  it "calculates sum" do
    verify_examples :sum, 
    [
      { input: nil, output: 0 },
      { input: [], output: 0 },
      { input: [17], output: 17 },
      { input: ["2",nil,"3.2",7], output: 12.2 },
      { input: [3*Math::PI,Math::PI], output: 4*Math::PI },
      { input: [2/3.to_r,1,5/3.to_r], output: (2+3+5)/3.to_r },
      { input: [1i,-1i], output: 0 }, 
      { input: [1+7i,2-2i,2+1i], output: 5+6i }, 
      { input: [3,2,1], output: 6 },
      { input: {5=>3,10=>2,"a"=>1}, output: 6 },
      { input: Set[3,2,1], output: 6 },
      { input: [2,1], output: 3 },
      { input: (1..2), output: 3 },
      { input: (1...3), output: 3 },
      { input: (1..2.5), output: 3 },
      { input: (0.5..0.7), output: Float::INFINITY },
      { input: (0.5..0.7).step(0.1), output: 0.5+0.6+0.7 },
      { input: (2/3.to_r..5/3.to_r), output: Float::INFINITY },
      { input: (2/3.to_r..5/3.to_r).step(1/3.to_r), output: (2+3+4+5)/3.to_r }, 
      # Range doesn't support Complex
    ]
  end

  it "calculates average" do
    verify_examples :average, 
    [
      { input: nil, output: nil },
      { input: [], output: nil },
      { input: [17], output: 17 },
      { input: ["2",nil,"3.2",7], output: (2+3.2+7)/4 },
      { input: [3*Math::PI,Math::PI], output: 2*Math::PI },
      { input: [1i,-1i], output: 0 }, 
      { input: [1+7i,2-2i,2+1i], output: (5+6i)/3 }, 
      { input: [3,2,1], output: 2 },
      { input: {5=>3,10=>2,"a"=>1}, output: 2 },
      { input: Set[3,2,1], output: 2 },
      { input: [2,1], output: 1.5 },
      { input: (1..2), output: 1.5 },
      { input: (1...3), output: 1.5 },
      { input: (1..2.5), output: 1.5 },
      { input: (0.5..0.7), output: 0.6 },
      { input: (0.5..0.7).step(0.1), output: 0.6 },
      { input: (2/3.to_r..5/3.to_r), output: 7/6.to_r },
      { input: (2/3.to_r..5/3.to_r).step(1/3.to_r), output: 7/6.to_r }, 
    ]
  end

  it "calculates median" do
    verify_examples :median, 
    [
      { input: nil, output: nil },
      { input: [], output: nil },
      { input: [17], output: 17 },
      { input: ["2",nil,"3.2",7], output: (2+3.2)/2 },
      { input: [3*Math::PI,Math::PI], output: 2*Math::PI },
      { input: [1i,-1i], output: 0 }, 
      { input: [1+7i,2-2i,2+1i], output: 2-2i }, 
      { input: [3,1,2], output: 2 },
      { input: {5=>3,10=>2,"a"=>1}, output: 2 },
      { input: [1,1,1,1,1,1000], output: 1 },
      { input: [9,8,20,15], output: (9+15)/2 },
      { input: Set[3,2,1], output: 2 },
      { input: Set[1,12,2], output: 2 },
      { input: [2,1], output: 1.5 },
      { input: (1..2), output: 1.5 },
      { input: (1...3), output: 1.5 },
      { input: (1..2.5), output: 1.5 },
      { input: (0.5..0.7), output: 0.6 },
      { input: (0.5..0.7).step(0.1), output: 0.6 },
      { input: (0.5..0.7).step(0.15), output: (0.5+0.65)/2 },
      { input: (2/3.to_r..5/3.to_r), output: 7/6.to_r },
      { input: (2/3.to_r...5/3.to_r).step(1/3.to_r), output: 1 }, 
      { input: ["-8",nil,1+1i,17.0,277/2.to_r], output: 1+1i }, 
    ]
  end
  
  it "calculates percentile" do
    verify_examples :percentile, 
    [
      { input: [190,1,12], params: [0], output: 1 },
      { input: [190,1,12], params: [0.5], output: 12 },
      { input: [190,1,12], params: [1], output: 190 },
      { input: [190,1,12], params: [-0.1], output: nil },
      { input: [190,1,12], params: [1.1], output: nil },

      { input: [1,2,3,4], params: [0.00], output: 1 },
      { input: [1,2,3,4], params: [0.25], output: 2 },
      { input: [1,2,3,4], params: [0.50], output: 3 },
      { input: [1,2,3,4], params: [0.75], output: 4 },
      { input: [1,2,3,4], params: [1.00], output: 4 },

      { input: nil, params: [0.5], output: nil },

      { input: [], params: [0], output: nil },
      { input: [], params: [0.5], output: nil },
      { input: [], params: [1], output: nil },

      { input: [17], params: [0], output: 17 },
      { input: [17], params: [0.5], output: 17 },
      { input: [17], params: [1], output: 17 },

      { input: (1.0..201.0), params: [0], output: 1 },
      { input: (1.0..201.0), params: [1], output: 201 },
      { input: (1.0..201.0), params: [0.33], output: 1+2*33 },
      { input: (1.0..201.0), params: [0.67], output: 1+2*67 },
      { input: (1.0..201.0), params: [1/6.to_r], output: 1.0+200/6.to_r, float_errors: true },

      { input: [29+3i,-100+2i,519-400i], params: [0.00], output: -100+2i },
      { input: [-100+2i,519-400i,29+3i], params: [0.25], output: 29+3i },
      { input: [-100+2i,29+3i,519-400i], params: [0.50], output: 29+3i },
      { input: [29+3i,519-400i,-100+2i], params: [0.75], output: 519-400i },
      { input: [519-400i,-100+2i,29+3i], params: [1.00], output: 519-400i },
    ]
  end
  
end