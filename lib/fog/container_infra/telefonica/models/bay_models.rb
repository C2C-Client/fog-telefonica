require 'fog/telefonica/models/collection'
require 'fog/container_infra/telefonica/models/bay_model'

module Fog
  module ContainerInfra
    class TeleFonica
      class BayModels < Fog::TeleFonica::Collection
        model Fog::ContainerInfra::TeleFonica::BayModel

        def all
          load_response(service.list_bay_models, 'baymodels')
        end

        def get(bay_model_uuid_or_name)
          resource = service.get_bay_model(bay_model_uuid_or_name).body
          new(resource)
        rescue Fog::ContainerInfra::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
