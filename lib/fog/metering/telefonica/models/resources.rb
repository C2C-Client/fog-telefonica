require 'fog/telefonica/models/collection'
require 'fog/metering/telefonica/models/resource'

module Fog
  module Metering
    class TeleFonica
      class Resources < Fog::TeleFonica::Collection
        model Fog::Metering::TeleFonica::Resource

        def all(_detailed = true)
          load_response(service.list_resources)
        end

        def find_by_id(resource_id)
          resource = service.get_resource(resource_id).body
          new(resource)
        rescue Fog::Metering::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
