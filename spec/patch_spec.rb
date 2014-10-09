require "spec_helper"

RSpec.describe "Patching" do
  it "should patch all default classes" do
    verify_that_all_stat_methods_defined_for EnumStat::DefaultClassesToPatch
  end
  it "can patch an arbitrary class" do
    test_class = Class.new
    sample_method = :average
    
    expect( test_class.instance_methods ).not_to include sample_method
    expect( test_class.new ).not_to respond_to sample_method

    expect{ EnumStat::patch_class(test_class) }.not_to raise_exception

    expect( test_class.instance_methods ).to include sample_method
    expect( test_class.new ).to respond_to sample_method

    verify_that_all_stat_methods_defined_for [test_class]
  end
end