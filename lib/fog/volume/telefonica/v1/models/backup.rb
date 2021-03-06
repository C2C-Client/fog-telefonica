require 'fog/volume/telefonica/models/backup'

module Fog
  module Volume
    class TeleFonica
      class V1
        class Backup < Fog::Volume::TeleFonica::Backup
          identity :id

          superclass.attributes.each { |attrib| attribute attrib }
        end
      end
    end
  end
end
