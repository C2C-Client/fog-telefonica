module Fog
  module Compute
    class TeleFonica
      class Real
        def delete_aggregate(uuid)
          request(
            :expects => [200, 202, 204],
            :method  => 'DELETE',
            :path    => "os-aggregates/#{uuid}"
          )
        end
      end

      class Mock
        def delete_aggregate(_uuid)
          response = Excon::Response.new
          response.status = 200
          response.headers = {
            "Content-Type"   => "text/html; charset=UTF-8",
            "Content-Length" => "0",
            "Date"           => Date.new
          }
          response
        end
      end
    end
  end
end
