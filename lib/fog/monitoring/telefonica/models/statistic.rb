require 'fog/telefonica/models/model'

module Fog
  module Monitoring
    class TeleFonica
      class Statistic < Fog::TeleFonica::Model
        identity :id

        attribute :name
        attribute :dimension
        attribute :columns
        attribute :statistics

        def to_s
          name
        end
      end
    end
  end
end
