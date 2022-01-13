require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/subnet_pool'

module Fog
  module Network
    class TeleFonica
      class SubnetPools < Fog::TeleFonica::Collection
        attribute :filters

        model Fog::Network::TeleFonica::SubnetPool

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_subnet_pools(filters), 'subnetpools')
        end

        def get(subnet_pool_id)
          subnet_pool = service.get_subnet_pool(subnet_pool_id).body['subnetpool']
          if subnet_pool
            new(subnet_pool)
          end
        rescue Fog::Network::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
