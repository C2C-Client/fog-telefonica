require 'fog/volume/telefonica/models/availability_zone'

module Fog
  module Volume
    class TeleFonica
      class V2
        class AvailabilityZone < Fog::Volume::TeleFonica::AvailabilityZone
          identity :zoneName

          attribute :zoneState
        end
      end
    end
  end
end
