require 'fog/telefonica/models/model'

module Fog
  module Compute
    class TeleFonica
      class AvailabilityZone < Fog::TeleFonica::Model
        identity :zoneName

        attribute :hosts
        attribute :zoneLabel
        attribute :zoneState

        def to_s
          zoneName
        end
      end
    end
  end
end
