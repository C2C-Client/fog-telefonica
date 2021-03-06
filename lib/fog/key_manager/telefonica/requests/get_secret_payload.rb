module Fog
  module KeyManager
    class TeleFonica
      class Real
        def get_secret_payload(uuid)
          request(
            :expects => [200],
            :method  => 'GET',
            :path    => "secrets/#{uuid}/payload",
            :headers => {
              'Accept' => '*/*'
            }
          )
        end
      end

      class Mock
      end
    end
  end
end
