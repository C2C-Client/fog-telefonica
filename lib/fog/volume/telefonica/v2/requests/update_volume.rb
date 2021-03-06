require 'fog/volume/telefonica/requests/update_volume'
require 'fog/volume/telefonica/v2/requests/real'

module Fog
  module Volume
    class TeleFonica
      module Real
        def update_volume(volume_id, data = {})
          data = data.select { |key| key == :name || key == :description || key == :metadata }
          request(
            :body    => Fog::JSON.encode('volume' => data),
            :expects => 200,
            :method  => 'PUT',
            :path    => "volumes/#{volume_id}"
          )
        end
      end
    end
  end
end
