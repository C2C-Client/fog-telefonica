require 'fog/telefonica/models/collection'
require 'fog/shared_file_system/telefonica/models/availability_zone'

module Fog
  module SharedFileSystem
    class TeleFonica
      class AvailabilityZones < Fog::TeleFonica::Collection
        model Fog::SharedFileSystem::TeleFonica::AvailabilityZone

        def all
          load_response(service.list_availability_zones(), 'availability_zones')
        end
      end
    end
  end
end
