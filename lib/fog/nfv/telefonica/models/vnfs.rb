require 'fog/telefonica/models/collection'
require 'fog/nfv/telefonica/models/vnf'

module Fog
  module NFV
    class TeleFonica
      class Vnfs < Fog::TeleFonica::Collection
        model Fog::NFV::TeleFonica::Vnf

        def all(options = {})
          load_response(service.list_vnfs(options), 'vnfs')
        end

        def get(uuid)
          data = service.get_vnf(uuid).body['vnf']
          new(data)
        rescue Fog::NFV::TeleFonica::NotFound
          nil
        end

        def destroy(uuid)
          vnf = get(uuid)
          vnf.destroy
        end
      end
    end
  end
end
