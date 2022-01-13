require 'fog/telefonica/models/collection'
require 'fog/nfv/telefonica/models/vnfd'

module Fog
  module NFV
    class TeleFonica
      class Vnfds < Fog::TeleFonica::Collection
        model Fog::NFV::TeleFonica::Vnfd

        def all(options = {})
          load_response(service.list_vnfds(options), 'vnfds')
        end

        def get(uuid)
          data = service.get_vnfd(uuid).body['vnfd']
          new(data)
        rescue Fog::NFV::TeleFonica::NotFound
          nil
        end

        def destroy(uuid)
          vnfd = get(uuid)
          vnfd.destroy
        end
      end
    end
  end
end
