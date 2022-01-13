require 'fog/telefonica/models/collection'
require 'fog/container_infra/telefonica/models/certificate'

module Fog
  module ContainerInfra
    class TeleFonica
      class Certificates < Fog::TeleFonica::Collection

        model Fog::ContainerInfra::TeleFonica::Certificate

        def create(bay_uuid)
          resource = service.create_certificate(bay_uuid).body
          new(resource)
        end

        def get(bay_uuid)
          resource = service.get_certificate(bay_uuid).body
          new(resource)
        rescue Fog::ContainerInfra::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
