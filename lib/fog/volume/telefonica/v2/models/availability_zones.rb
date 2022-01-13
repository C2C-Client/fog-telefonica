require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v2/models/availability_zone'
require 'fog/volume/telefonica/models/availability_zones'

module Fog
  module Volume
    class TeleFonica
      class V2
        class AvailabilityZones < Fog::TeleFonica::Collection
          model Fog::Volume::TeleFonica::V2::AvailabilityZone
          include Fog::Volume::TeleFonica::AvailabilityZones
        end
      end
    end
  end
end
