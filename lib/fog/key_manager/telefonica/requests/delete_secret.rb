module Fog
  module KeyManager
    class TeleFonica
      class Real
        def delete_secret(id)
          request(
            :expects => [204],
            :method  => 'DELETE',
            :path    => "secrets/#{id}"
          )
        end
      end

      class Mock
      end
    end
  end
end
