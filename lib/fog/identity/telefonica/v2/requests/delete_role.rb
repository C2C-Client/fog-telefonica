module Fog
  module Identity
    class TeleFonica
      class V2
        class Real
          def delete_role(role_id)
            request(
              :expects => [200, 204],
              :method  => 'DELETE',
              :path    => "/OS-KSADM/roles/#{role_id}"
            )
          end
        end

        class Mock
          def delete_role(role_id)
            response = Excon::Response.new
            if data[:roles][role_id]
              data[:roles].delete(role_id)
              response.status = 204
              response
            else
              raise Fog::Identity::TeleFonica::NotFound
            end
          end
        end
      end
    end
  end
end
