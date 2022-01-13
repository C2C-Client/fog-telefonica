require 'fog/telefonica/models/collection'
require 'fog/key_manager/telefonica/models/secret'

module Fog
  module KeyManager
    class TeleFonica
      class Secrets < Fog::TeleFonica::Collection
        model Fog::KeyManager::TeleFonica::Secret

        def all(options = {})
          load_response(service.list_secrets(options), 'secrets')
        end

        def get(secret_ref)
          if secret = service.get_secret(secret_ref).body
            new(secret)
          end
        rescue Fog::Compute::TeleFonica::NotFound
          nil
        end

      end
    end
  end
end
