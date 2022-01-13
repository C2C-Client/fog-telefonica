module Fog
  module Identity
    class TeleFonica
      class V3
        class Real
          def check_project_group_role(id, group_id, role_id)
            request(
              :expects => [204],
              :method  => 'HEAD',
              :path    => "projects/#{id}/groups/#{group_id}/roles/#{role_id}"
            )
          end
        end

        class Mock
        end
      end
    end
  end
end
