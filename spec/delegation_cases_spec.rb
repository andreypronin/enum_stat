require "spec_helper"

RSpec.describe "Delegation cases" do
  it "should define all stat methods" do
    verify_that_all_stat_methods_defined_for EnumStat::DelegationCases.keys
  end
end