module Fog
  module Monitoring
    class TeleFonica
      class Real
        def delete_alarm(id)
          request(
            :expects => [204],
            :method  => 'DELETE',
            :path    => "alarms/#{id}"
          )
        end
      end

      class Mock
      end
    end
  end
end
