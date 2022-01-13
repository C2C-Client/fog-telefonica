module Fog
  module Compute
    class TeleFonica
      class Real
        def create_security_group(name, description)
          data = {
            'security_group' => {
              'name'        => name,
              'description' => description
            }
          }

          request(
            :body    => Fog::JSON.encode(data),
            :expects => 200,
            :method  => 'POST',
            :path    => 'os-security-groups'
          )
        end
      end

      class Mock
        def create_security_group(name, description)
          Fog::Identity::TeleFonica.new(:telefonica_auth_url => credentials[:telefonica_auth_url], :telefonica_identity_api_version => 'v2.0')
          tenant_id = Fog::Identity::TeleFonica::V2::Mock.data[current_tenant][:tenants].keys.first
          security_group_id = Fog::Mock.random_numbers(2).to_i + 1
          data[:security_groups][security_group_id.to_s] = {
            'tenant_id'   => tenant_id,
            'rules'       => [],
            'id'          => security_group_id,
            'name'        => name,
            'description' => description
          }

          response = Excon::Response.new
          response.status = 200
          response.headers = {
            'X-Compute-Request-Id' => "req-#{Fog::Mock.random_hex(32)}",
            'Content-Type'         => 'application/json',
            'Content-Length'       => Fog::Mock.random_numbers(3).to_s,
            'Date'                 => Date.new
          }
          response.body = {
            'security_group' => data[:security_groups][security_group_id.to_s]
          }
          response
        end
      end
    end
  end
end
