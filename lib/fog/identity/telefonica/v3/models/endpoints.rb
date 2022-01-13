require 'fog/telefonica/models/collection'
require 'fog/identity/telefonica/v3/models/service'

module Fog
  module Identity
    class TeleFonica
      class V3
        class Endpoints < Fog::TeleFonica::Collection
          model Fog::Identity::TeleFonica::V3::Endpoint

          def all(options = {})
            load_response(service.list_endpoints(options), 'endpoints')
          end

          def find_by_id(id)
            cached_endpoint = find { |endpoint| endpoint.id == id }
            return cached_endpoint if cached_endpoint
            endpoint_hash = service.get_endpoint(id).body['endpoint']
            Fog::Identity::TeleFonica::V3::Endpoint.new(
              endpoint_hash.merge(:service => service)
            )
          end
        end
      end
    end
  end
end
