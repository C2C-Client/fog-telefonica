require 'fog/telefonica/models/collection'
require 'fog/shared_file_system/telefonica/models/network'

module Fog
  module SharedFileSystem
    class TeleFonica
      class Networks < Fog::TeleFonica::Collection
        model Fog::SharedFileSystem::TeleFonica::Network

        def all(options = {})
          load_response(service.list_share_networks_detail(options), 'share_networks')
        end

        def find_by_id(id)
          net_hash = service.get_share_network(id).body['share_network']
          new(net_hash.merge(:service => service))
        end

        alias get find_by_id

        def destroy(id)
          net = find_by_id(id)
          net.destroy
        end
      end
    end
  end
end
