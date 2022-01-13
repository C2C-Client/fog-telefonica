require 'fog/telefonica/models/collection'
require 'fog/orchestration/telefonica/models/resource'

module Fog
  module Orchestration
    class TeleFonica
      class Resources < Fog::TeleFonica::Collection
        model Fog::Orchestration::TeleFonica::Resource

        def types
          service.list_resource_types.body['resource_types'].sort
        end

        def all(options = {}, deprecated_options = {})
          data = service.list_resources(options, deprecated_options)
          load_response(data, 'resources')
        end

        def get(resource_name, stack = nil)
          stack = first.stack if stack.nil?
          data  = service.show_resource_data(stack.stack_name, stack.id, resource_name).body['resource']
          new(data)
        rescue Fog::Compute::TeleFonica::NotFound
          nil
        end

        def metadata(stack_name, stack_id, resource_name)
          service.show_resource_metadata(stack_name, stack_id, resource_name).body['resource']
        rescue Fog::Compute::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
