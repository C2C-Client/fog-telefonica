module Fog
  module Volume
    class TeleFonica
      module Real
        def delete_transfer(transfer_id)
          request(
            :expects => 202,
            :method  => 'DELETE',
            :path    => "os-volume-transfer/#{transfer_id}"
          )
        end
      end
    end
  end
end
