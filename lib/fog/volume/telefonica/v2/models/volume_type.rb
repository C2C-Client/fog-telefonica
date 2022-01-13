require 'fog/volume/telefonica/models/volume_type'

module Fog
  module Volume
    class TeleFonica
      class V2
        class VolumeType < Fog::Volume::TeleFonica::VolumeType
          identity :id

          attribute :name
          attribute :volume_backend_name
        end
      end
    end
  end
end
