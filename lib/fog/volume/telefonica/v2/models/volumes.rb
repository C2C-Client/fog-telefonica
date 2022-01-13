require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v2/models/volume'
require 'fog/volume/telefonica/models/volumes'

module Fog
  module Volume
    class TeleFonica
      class V2
        class Volumes < Fog::TeleFonica::Collection
          model Fog::Volume::TeleFonica::V2::Volume
          include Fog::Volume::TeleFonica::Volumes
        end
      end
    end
  end
end
