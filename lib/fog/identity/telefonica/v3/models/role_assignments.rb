require 'fog/telefonica/models/collection'
require 'fog/identity/telefonica/v3/models/role'

module Fog
  module Identity
    class TeleFonica
      class V3
        class RoleAssignments < Fog::TeleFonica::Collection
          model Fog::Identity::TeleFonica::V3::RoleAssignment

          def all(options = {})
            load_response(service.list_role_assignments(options), 'role_assignments')
          end

          def filter_by(options = {})
            Fog::Logger.deprecation("Calling TeleFonica[:keystone].role_assignments.filter_by(options) method which"\
                                    " is not part of standard interface and is deprecated, call "\
                                    " .role_assignments.all(options) or .role_assignments.summary(options) instead.")
            all(options)
          end
        end
      end
    end
  end
end
