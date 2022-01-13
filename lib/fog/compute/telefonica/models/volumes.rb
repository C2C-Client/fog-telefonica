require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/volume'

module Fog
  module Compute
    class TeleFonica
      class Volumes < Fog::TeleFonica::Collection
        model Fog::Compute::TeleFonica::Volume

        def all(options = true)
          if !options.kind_of?(Hash)
            if options
              Fog::Logger.deprecation('Calling TeleFonica[:compute].volumes.all(true) is deprecated, use .volumes.all')
            else
              Fog::Logger.deprecation('Calling TeleFonica[:compute].volumes.all(false) is deprecated, use .volumes.summary')
            end
            load_response(service.list_volumes(options), 'volumes')
          else
            load_response(service.list_volumes_detail(options), 'volumes')
          end
        end

        def summary(options = {})
          load_response(service.list_volumes(options), 'volumes')
        end

        def get(volume_id)
          if volume = service.get_volume_details(volume_id).body['volume']
            new(volume)
          end
        rescue Fog::Compute::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
