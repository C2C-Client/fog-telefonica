require 'fog/telefonica/models/model'

module Fog
  module Monitoring
    class TeleFonica
      class Measurement < Fog::TeleFonica::Model
        identity :id

        attribute :name
        attribute :dimensions
        attribute :columns
        attribute :measurements

        def to_s
          name
        end
      end
    end
  end
end
