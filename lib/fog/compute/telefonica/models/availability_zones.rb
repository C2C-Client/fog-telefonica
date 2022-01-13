require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/availability_zone'

module Fog
  module Compute
    class TeleFonica
      class AvailabilityZones < Fog::TeleFonica::Collection
        model Fog::Compute::TeleFonica::AvailabilityZone

        def all(options = {})
          data = service.list_zones_detailed(options)
          load_response(data, 'availabilityZoneInfo')
        end

        def summary(options = {})
          data = service.list_zones(options)
          load_response(data, 'availabilityZoneInfo')
        end
      end
    end
  end
end
