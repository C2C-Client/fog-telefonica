require 'fog/telefonica/models/collection'
require 'fog/introspection/telefonica/models/rules'

module Fog
  module Introspection
    class TeleFonica
      class RulesCollection < Fog::TeleFonica::Collection
        model Fog::Introspection::TeleFonica::Rules

        def all(_options = {})
          load_response(service.list_rules, 'rules')
        end

        def get(uuid)
          data = service.get_rules(uuid).body
          new(data)
        rescue Fog::Introspection::TeleFonica::NotFound
          nil
        end

        def destroy(uuid)
          rules = get(uuid)
          rules.destroy
        end

        def destroy_all
          service.delete_rules_all
        end
      end
    end
  end
end
