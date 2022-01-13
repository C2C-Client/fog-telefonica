require 'fog/telefonica/models/collection'
require 'fog/key_manager/telefonica/models/container'

module Fog
  module KeyManager
    class TeleFonica
      class Containers < Fog::TeleFonica::Collection
        model Fog::KeyManager::TeleFonica::Container

        def all(options = {})
          load_response(service.list_containers(options), 'containers')
        end

        def get(secret_ref)
          if secret = service.get_container(secret_ref).body
            new(secret)
          end
        rescue Fog::Compute::TeleFonica::NotFound
          nil
        end

      end
    end
  end
end
