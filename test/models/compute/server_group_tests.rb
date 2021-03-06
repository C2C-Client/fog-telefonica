require "test_helper"

describe "Fog::Compute::TeleFonica::ServerGroup" do
  describe "validate_server_group_policy" do
    it "contains only allowed policies" do
      ['affinity', 'anti-affinity', 'soft-affinity', 'soft-anti-affinity'].each do |policy|
        Fog::Compute::TeleFonica::ServerGroup.validate_server_group_policy(policy).must_equal true
      end
    end

    it "raises an error" do
      assert_raises ArgumentError do
        Fog::Compute::TeleFonica::ServerGroup.validate_server_group_policy('invalid-policy')
      end
    end
  end
end
