require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v2/models/volume_type'
require 'fog/volume/telefonica/models/volume_types'

module Fog
  module Volume
    class TeleFonica
      class V2
        class VolumeTypes < Fog::TeleFonica::Collection
          model Fog::Volume::TeleFonica::V2::VolumeType
          include Fog::Volume::TeleFonica::VolumeTypes
        end
      end
    end
  end
end
