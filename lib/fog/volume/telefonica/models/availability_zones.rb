require 'fog/telefonica/models/collection'

module Fog
  module Volume
    class TeleFonica
      module AvailabilityZones
        def all(options = {})
          data = service.list_zones(options)
          load_response(data, 'availabilityZoneInfo')
        end
      end
    end
  end
end
