require 'fog/telefonica/models/collection'
require 'fog/shared_file_system/telefonica/models/share_access_rule'

module Fog
  module SharedFileSystem
    class TeleFonica
      class ShareExportLocations < Fog::TeleFonica::Collection
        model Fog::SharedFileSystem::TeleFonica::ShareExportLocation

        attr_accessor :share

        def all
          requires :share
          load_response(service.list_share_export_locations(@share.id), 'export_locations')
        end

        def find_by_id(id)
          location_hash = service.get_share_export_location(@share.id,id).body['export_location']
          new(location_hash.merge(:service => service))
        end

        alias get find_by_id

        def new(attributes = {})
          requires :share
          super({:share => @share}.merge!(attributes))
        end
      end
    end
  end
end
