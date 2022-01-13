require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v2/models/snapshot'
require 'fog/volume/telefonica/models/snapshots'

module Fog
  module Volume
    class TeleFonica
      class V2
        class Snapshots < Fog::TeleFonica::Collection
          model Fog::Volume::TeleFonica::V2::Snapshot
          include Fog::Volume::TeleFonica::Snapshots
        end
      end
    end
  end
end
