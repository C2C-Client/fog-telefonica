require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v2/models/transfer'
require 'fog/volume/telefonica/models/transfers'

module Fog
  module Volume
    class TeleFonica
      class V2
        class Transfers < Fog::TeleFonica::Collection
          model Fog::Volume::TeleFonica::V2::Transfer
          include Fog::Volume::TeleFonica::Transfers
        end
      end
    end
  end
end
