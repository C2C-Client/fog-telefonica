require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v1/models/transfer'
require 'fog/volume/telefonica/models/transfers'

module Fog
  module Volume
    class TeleFonica
      class V1
        class Transfers < Fog::TeleFonica::Collection
          model Fog::Volume::TeleFonica::V1::Transfer
          include Fog::Volume::TeleFonica::Transfers
        end
      end
    end
  end
end
