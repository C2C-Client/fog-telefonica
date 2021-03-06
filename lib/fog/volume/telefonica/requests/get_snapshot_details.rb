module Fog
  module Volume
    class TeleFonica
      module Real
        def get_snapshot_details(snapshot_id)
          request(
            :expects => 200,
            :method  => 'GET',
            :path    => "snapshots/#{snapshot_id}"
          )
        end
      end
    end
  end
end
