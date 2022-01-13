require 'fog/telefonica/models/collection'
require 'fog/dns/telefonica/v2/models/zone'

module Fog
  module DNS
    class TeleFonica
      class V2
        class Zones < Fog::TeleFonica::Collection
          model Fog::DNS::TeleFonica::V2::Zone

          def all(options = {})
            load_response(service.list_zones(options), 'zones')
          end

          def find_by_id(id, options = {})
            zone_hash = service.get_zone(id, options).body
            new(zone_hash.merge(:service => service))
          end

          alias get find_by_id

          def destroy(id, options = {})
            zone = find_by_id(id, options)
            zone.destroy
          end
        end
      end
    end
  end
end
