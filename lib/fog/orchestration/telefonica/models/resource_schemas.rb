require 'fog/telefonica/models/collection'

module Fog
  module Orchestration
    class TeleFonica
      class ResourceSchemas < Fog::TeleFonica::Collection
        def get(resource_type)
          service.show_resource_schema(resource_type).body
        rescue Fog::Compute::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
