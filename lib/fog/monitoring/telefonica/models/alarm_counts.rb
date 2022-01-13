require 'fog/telefonica/models/collection'
require 'fog/monitoring/telefonica/models/alarm_count'

module Fog
  module Monitoring
    class TeleFonica
      class AlarmCounts < Fog::TeleFonica::Collection
        model Fog::Monitoring::TeleFonica::AlarmCount

        def get(options = {})
          load_response(service.get_alarm_counts(options))
        end
      end
    end
  end
end
