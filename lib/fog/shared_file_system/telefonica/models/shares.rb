require 'fog/telefonica/models/collection'
require 'fog/shared_file_system/telefonica/models/share'

module Fog
  module SharedFileSystem
    class TeleFonica
      class Shares < Fog::TeleFonica::Collection
        model Fog::SharedFileSystem::TeleFonica::Share

        def all(options = {})
          load_response(service.list_shares_detail(options), 'shares')
        end

        def find_by_id(id)
          share_hash = service.get_share(id).body['share']
          new(share_hash.merge(:service => service))
        end

        alias get find_by_id

        def destroy(id)
          share = find_by_id(id)
          share.destroy
        end
      end
    end
  end
end
