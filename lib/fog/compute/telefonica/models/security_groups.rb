require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/security_group'

module Fog
  module Compute
    class TeleFonica
      class SecurityGroups < Fog::TeleFonica::Collection
        model Fog::Compute::TeleFonica::SecurityGroup

        def all(options = {})
          load_response(service.list_security_groups(options), 'security_groups')
        end

        def get(security_group_id)
          if security_group_id
            new(service.get_security_group(security_group_id).body['security_group'])
          end
        rescue Fog::Compute::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
