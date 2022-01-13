require 'fog/core/collection'

module Fog
  module Compute
    class TeleFonica
      class VolumeAttachments < Fog::Collection
        model Fog::Compute::TeleFonica::VolumeAttachment

        def get(server_id)
          if server_id
            puts service.list_volume_attachments(server_id).body
            load(service.list_volume_attachments(server_id).body['volumeAttachments'])
          end
        rescue Fog::Compute::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
