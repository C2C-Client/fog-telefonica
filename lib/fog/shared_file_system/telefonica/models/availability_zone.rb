require 'fog/telefonica/models/model'

module Fog
  module SharedFileSystem
    class TeleFonica
      class AvailabilityZone < Fog::TeleFonica::Model
        identity :id

        attribute :name
        attribute :created_at
        attribute :updated_at
      end
    end
  end
end
