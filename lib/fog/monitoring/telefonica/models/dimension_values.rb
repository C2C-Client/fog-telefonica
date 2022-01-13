require 'fog/telefonica/models/collection'
require 'fog/monitoring/telefonica/models/dimension_value'

module Fog
  module Monitoring
    class TeleFonica
      class DimensionValues < Fog::TeleFonica::Collection
        model Fog::Monitoring::TeleFonica::DimensionValue

        def all(dimension_name, options = {})
          load_response(service.list_dimension_values(dimension_name, options), 'elements')
        end
      end
    end
  end
end
