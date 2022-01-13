require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/security_group_rule'

module Fog
  module Compute
    class TeleFonica
      class SecurityGroupRules < Fog::TeleFonica::Collection
        model Fog::Compute::TeleFonica::SecurityGroupRule

        def get(security_group_rule_id)
          if security_group_rule_id
            body = service.get_security_group_rule(security_group_rule_id).body
            new(body['security_group_rule'])
          end
        rescue Fog::Compute::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
