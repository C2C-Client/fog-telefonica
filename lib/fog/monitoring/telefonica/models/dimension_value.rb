require 'fog/telefonica/models/model'

module Fog
  module Monitoring
    class TeleFonica
      class DimensionValue < Fog::TeleFonica::Model
        identity :id

        attribute :metric_name
        attribute :dimension_name
        attribute :values

        def to_s
          name
        end
      end
    end
  end
end
