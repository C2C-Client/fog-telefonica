module Fog
  module Identity
    class TeleFonica
      class V3
        class Real
          def revoke_domain_user_role(id, user_id, role_id)
            request(
              :expects => [204],
              :method  => 'DELETE',
              :path    => "domains/#{id}/users/#{user_id}/roles/#{role_id}"
            )
          end
        end

        class Mock
        end
      end
    end
  end
end
