require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v1/models/snapshot'
require 'fog/volume/telefonica/models/snapshots'

module Fog
  module Volume
    class TeleFonica
      class V1
        class Snapshots < Fog::TeleFonica::Collection
          model Fog::Volume::TeleFonica::V1::Snapshot
          include Fog::Volume::TeleFonica::Snapshots
        end
      end
    end
  end
end
