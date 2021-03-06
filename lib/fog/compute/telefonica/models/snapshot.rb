require 'fog/telefonica/models/model'
require 'fog/compute/telefonica/models/metadata'

module Fog
  module Compute
    class TeleFonica
      class Snapshot < Fog::TeleFonica::Model
        identity :id

        attribute :name,        :aliases => 'displayName'
        attribute :description, :aliases => 'displayDescription'
        attribute :volume_id,   :aliases => 'volumeId'
        attribute :created_at,  :aliases => 'createdAt'
        attribute :status
        attribute :size

        def save(force = false)
          requires :volume_id, :name, :description
          data = service.create_snapshot(volume_id, name, description, force)
          merge_attributes(data.body['snapshot'])
          true
        end

        def destroy
          requires :id
          service.delete_snapshot(id)
          true
        end
      end
    end
  end
end
