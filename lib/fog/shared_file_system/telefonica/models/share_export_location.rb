require 'fog/telefonica/models/model'

module Fog
  module SharedFileSystem
    class TeleFonica
      class ShareExportLocation < Fog::TeleFonica::Model
        identity :id

        attribute :share_instance_id
        attribute :path
        attribute :is_admin_only
        attribute :preferred
      end
    end
  end
end
