require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/network'

module Fog
  module Network
    class TeleFonica
      class Networks < Fog::TeleFonica::Collection
        attribute :filters

        model Fog::Network::TeleFonica::Network

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_networks(filters), 'networks')
        end

        def get(network_id)
          if network = service.get_network(network_id).body['network']
            new(network)
          end
        rescue Fog::Network::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
