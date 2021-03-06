module Fog
  module Network
    class TeleFonica
      class Real
        def delete_subnet(subnet_id)
          request(
            :expects => 204,
            :method  => 'DELETE',
            :path    => "subnets/#{subnet_id}"
          )
        end
      end

      class Mock
        def delete_subnet(subnet_id)
          response = Excon::Response.new
          if list_subnets.body['subnets'].map { |r| r['id'] }.include? subnet_id
            data[:subnets].delete(subnet_id)
            response.status = 204
            response
          else
            raise Fog::Network::TeleFonica::NotFound
          end
        end
      end
    end
  end
end
