module Fog
  module Compute
    class TeleFonica
      class Real
        def list_addresses(server_id)
          request(
            :expects => [200, 203],
            :method  => 'GET',
            :path    => "servers/#{server_id}/ips"
          )
        end
      end

      class Mock
        def list_addresses(server_id)
          response = Excon::Response.new
          server = list_servers_detail.body['servers'].find { |srv| srv['id'] == server_id }
          if server
            response.status = [200, 203][rand(2)]
            response.body = {'addresses' => server['addresses']}
            response
          else
            raise Fog::Compute::TeleFonica::NotFound
          end
        end
      end
    end
  end
end
