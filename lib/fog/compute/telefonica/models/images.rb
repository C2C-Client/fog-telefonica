require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/image'

module Fog
  module Compute
    class TeleFonica
      class Images < Fog::TeleFonica::Collection
        attribute :filters

        model Fog::Compute::TeleFonica::Image

        attribute :server

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          data = service.list_images_detail(filters)
          images = load_response(data, 'images')
          if server
            replace(select { |image| image.server_id == server.id })
          end
          images
        end

        def get(image_id)
          data = service.get_image_details(image_id).body['image']
          new(data)
        rescue Fog::Compute::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
