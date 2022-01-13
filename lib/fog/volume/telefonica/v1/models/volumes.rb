require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v1/models/volume'
require 'fog/volume/telefonica/models/volumes'

module Fog
  module Volume
    class TeleFonica
      class V1
        class Volumes < Fog::TeleFonica::Collection
          model Fog::Volume::TeleFonica::V1::Volume
          include Fog::Volume::TeleFonica::Volumes
        end
      end
    end
  end
end
