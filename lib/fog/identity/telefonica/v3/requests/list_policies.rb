module Fog
  module Identity
    class TeleFonica
      class V3
        class Real
          def list_policies(options = {})
            request(
              :expects => [200],
              :method  => 'GET',
              :path    => "policies",
              :query   => options
            )
          end
        end

        class Mock
          def list_policies(options = {})
          end
        end
      end
    end
  end
end
