require 'fog/telefonica/models/model'

module Fog
  module Monitoring
    class TeleFonica
      class AlarmCount < Fog::TeleFonica::Model
        attribute :links
        attribute :columns
        attribute :counts

        def to_s
          name
        end
      end
    end
  end
end
