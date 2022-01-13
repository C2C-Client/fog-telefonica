require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v1/models/volume_type'
require 'fog/volume/telefonica/models/volume_types'

module Fog
  module Volume
    class TeleFonica
      class V1
        class VolumeTypes < Fog::TeleFonica::Collection
          model Fog::Volume::TeleFonica::V1::VolumeType
          include Fog::Volume::TeleFonica::VolumeTypes
        end
      end
    end
  end
end
