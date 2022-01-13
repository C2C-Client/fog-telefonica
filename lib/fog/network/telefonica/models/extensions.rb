require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/extension'

module Fog
  module Network
    class TeleFonica
      class Extensions < Fog::TeleFonica::Collection
        attribute :filters

        model Fog::Network::TeleFonica::Extension

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_extensions(filters), 'extensions')
        end

        def get(extension_id)
          if extension = service.get_extension(extension_id).body['extension']
            new(extension)
          end
        rescue Fog::Network::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
