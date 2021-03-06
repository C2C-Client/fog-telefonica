module Fog
  module KeyManager
    class TeleFonica
      class Real
        def get_secret(uuid)
          request(
            :expects => [200],
            :method  => 'GET',
            :path    => "secrets/#{uuid}",
          )
        end
      end

      class Mock
      end
    end
  end
end
