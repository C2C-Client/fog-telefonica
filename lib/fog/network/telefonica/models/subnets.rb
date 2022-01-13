require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/subnet'

module Fog
  module Network
    class TeleFonica
      class Subnets < Fog::TeleFonica::Collection
        attribute :filters

        model Fog::Network::TeleFonica::Subnet

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_subnets(filters), 'subnets')
        end

        def get(subnet_id)
          if subnet = service.get_subnet(subnet_id).body['subnet']
            new(subnet)
          end
        rescue Fog::Network::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
