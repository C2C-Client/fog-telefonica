require 'fog/telefonica/models/collection'
require 'fog/planning/telefonica/models/role'

module Fog
  module TeleFonica
    class Planning
      class Roles < Fog::TeleFonica::Collection
        model Fog::TeleFonica::Planning::Role

        def all(options = {})
          load_response(service.list_roles(options))
        end
      end
    end
  end
end
