require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/address'

module Fog
  module Compute
    class TeleFonica
      class Addresses < Fog::TeleFonica::Collection
        model Fog::Compute::TeleFonica::Address

        def all(options = {})
          load_response(service.list_all_addresses(options), 'floating_ips')
        end

        def get(address_id)
          if address = service.get_address(address_id).body['floating_ip']
            new(address)
          end
        rescue Fog::Compute::TeleFonica::NotFound
          nil
        end

        def get_address_pools
          service.list_address_pools.body['floating_ip_pools']
        end
      end
    end
  end
end
