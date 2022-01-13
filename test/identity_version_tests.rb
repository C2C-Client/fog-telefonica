require 'test_helper'

describe "Fog::Identity[:telefonica] | versions" do
  before do
    @old_mock_value = Excon.defaults[:mock]
    @old_credentials = Fog.credentials
  end

  it "v2" do
    Fog.credentials = {:telefonica_auth_url => 'http://telefonica:35357'}

    assert(Fog::Identity::TeleFonica::V2::Real) do
      Fog::Identity[:telefonica].class
    end
  end

  it "v3" do
    Fog.credentials = {:telefonica_auth_url => 'http://telefonica:35357'}

    assert(Fog::Identity::TeleFonica::V3::Real) do
      Fog::Identity[:telefonica].class
    end
  end

  after do
    Excon.defaults[:mock] = @old_mock_value
    Fog.credentials = @old_credentials
  end
end
