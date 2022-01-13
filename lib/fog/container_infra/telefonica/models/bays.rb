require 'fog/telefonica/models/collection'
require 'fog/container_infra/telefonica/models/bay'

module Fog
  module ContainerInfra
    class TeleFonica
      class Bays < Fog::TeleFonica::Collection
        model Fog::ContainerInfra::TeleFonica::Bay

        def all
          load_response(service.list_bays, "bays")
        end

        def get(bay_uuid_or_name)
          resource = service.get_bay(bay_uuid_or_name).body
          new(resource)
        rescue Fog::ContainerInfra::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
