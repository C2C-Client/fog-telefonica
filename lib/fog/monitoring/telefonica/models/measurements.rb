require 'fog/telefonica/models/collection'
require 'fog/monitoring/telefonica/models/measurement'

module Fog
  module Monitoring
    class TeleFonica
      class Measurements < Fog::TeleFonica::Collection
        model Fog::Monitoring::TeleFonica::Measurement

        def find(options = {})
          load_response(service.find_measurements(options), 'elements')
        end
      end
    end
  end
end
