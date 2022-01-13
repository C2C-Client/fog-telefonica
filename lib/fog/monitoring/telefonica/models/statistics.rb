require 'fog/telefonica/models/collection'
require 'fog/monitoring/telefonica/models/statistic'

module Fog
  module Monitoring
    class TeleFonica
      class Statistics < Fog::TeleFonica::Collection
        model Fog::Monitoring::TeleFonica::Statistic

        def all(options = {})
          load_response(service.list_statistics(options), 'elements')
        end
      end
    end
  end
end
