require 'fog/telefonica/models/collection'
require 'fog/metering/telefonica/models/event'

module Fog
  module Metering
    class TeleFonica
      class Events < Fog::TeleFonica::Collection
        model Fog::Metering::TeleFonica::Event

        def all(q = [])
          load_response(service.list_events(q))
        end

        def find_by_id(message_id)
          event = service.get_event(message_id).body
          new(event)
        rescue Fog::Metering::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
