require 'fog/telefonica/models/model'

module Fog
  module Volume
    class TeleFonica
      class Transfer < Fog::TeleFonica::Model
        def save
          requires :name, :volume_id
          data = service.create_transfer(volume_id, :name => name)
          merge_attributes(data.body['transfer'])
          true
        end

        def destroy
          requires :id
          service.delete_transfer(id)
          true
        end

        def initialize(attributes)
          # Old 'connection' is renamed as service and should be used instead
          prepare_service_value(attributes)
          super
        end
      end
    end
  end
end
