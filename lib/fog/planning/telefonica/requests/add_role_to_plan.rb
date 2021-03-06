module Fog
  module TeleFonica
    class Planning
      class Real
        def add_role_to_plan(plan_uuid, role_uuid)
          request(
            :expects => [201],
            :method  => 'POST',
            :path    => "plans/#{plan_uuid}/roles",
            :body    => Fog::JSON.encode('uuid' => role_uuid)
          )
        end
      end

      class Mock
        def add_role_to_plan(_plan_uuid, _role_uuid)
          response = Excon::Response.new
          response.status = 201
          response.body = {
            "created_at"  => "2014-09-26T20:23:14.222815",
            "description" => "Development testing cloud",
            "name"        => "dev-cloud",
            "parameters"  => [],
            "roles"       => [
              {
                "description" => "TeleFonica hypervisor node. Can be wrapped in a ResourceGroup for scaling.\n",
                "name"        => "compute",
                "uuid"        => "f72c0656-5696-4c66-81a5-d6d88a48e385",
                "version"     => 1
              }
            ],
            "updated_at"  => nil,
            "uuid"        => "53268a27-afc8-4b21-839f-90227dd7a001"
          }
          response
        end
      end
    end
  end
end
