require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/flavor'

module Fog
  module Compute
    class TeleFonica
      class Flavors < Fog::TeleFonica::Collection
        model Fog::Compute::TeleFonica::Flavor

        def all(options = {})
          data = service.list_flavors_detail(options)
          load_response(data, 'flavors')
        end

        def summary(options = {})
          data = service.list_flavors(options)
          load_response(data, 'flavors')
        end

        def get(flavor_id)
          data = service.get_flavor_details(flavor_id).body['flavor']
          new(data)
        rescue Fog::Compute::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
