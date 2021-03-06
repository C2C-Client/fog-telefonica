require 'fog/telefonica/models/collection'
require 'fog/monitoring/telefonica/models/alarm'

module Fog
  module Monitoring
    class TeleFonica
      class Alarms < Fog::TeleFonica::Collection
        model Fog::Monitoring::TeleFonica::Alarm

        def all(options = {})
          load_response(service.list_alarms(options), 'elements')
        end

        def find_by_id(id)
          cached_alarm = detect { |alarm| alarm.id == id }
          return cached_alarm if cached_alarm
          alarm_hash = service.get_alarm(id).body
          Fog::Monitoring::TeleFonica::Alarm.new(
            alarm_hash.merge(:service => service)
          )
        end

        def destroy(id)
          alarm = find_by_id(id)
          alarm.destroy
        end
      end
    end
  end
end
