require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v1/models/backup'
require 'fog/volume/telefonica/models/backups'

module Fog
  module Volume
    class TeleFonica
      class V1
        class Backups < Fog::TeleFonica::Collection
          model Fog::Volume::TeleFonica::V1::Backup
          include Fog::Volume::TeleFonica::Backups
        end
      end
    end
  end
end
