require "spec_helper"

RSpec.describe "Special cases" do
  it "should include all stat methods" do
    verify_that_all_stat_methods_defined_for EnumStat::SpecialCases.values
  end
end