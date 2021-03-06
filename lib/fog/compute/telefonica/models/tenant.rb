require 'fog/telefonica/models/model'

module Fog
  module Compute
    class TeleFonica
      class Tenant < Fog::TeleFonica::Model
        identity :id

        attribute :description
        attribute :enabled
        attribute :name

        def to_s
          name
        end

        def usage(start_date, end_date)
          requires :id
          service.get_usage(id, start_date, end_date).body['tenant_usage']
        end
      end
    end
  end
end
