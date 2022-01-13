require 'fog/telefonica/models/model'

module Fog
  module Event
    class TeleFonica
      class Event < Fog::TeleFonica::Model
        identity :message_id

        attribute :event_type
        attribute :generated
        attribute :raw
        attribute :traits
      end
    end
  end
end
