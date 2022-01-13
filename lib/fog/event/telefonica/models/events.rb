require 'fog/telefonica/models/collection'
require 'fog/event/telefonica/models/event'

module Fog
  module Event
    class TeleFonica
      class Events < Fog::TeleFonica::Collection
        model Fog::Event::TeleFonica::Event

        def all(q = [])
          load_response(service.list_events(q))
        end

        def find_by_id(message_id)
          event = service.get_event(message_id).body
          new(event)
        rescue Fog::Event::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
