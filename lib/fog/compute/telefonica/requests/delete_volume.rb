module Fog
  module Compute
    class TeleFonica
      class Real
        def delete_volume(volume_id)
          request(
            :expects => 202,
            :method  => 'DELETE',
            :path    => "os-volumes/#{volume_id}"
          )
        end
      end

      class Mock
        def delete_volume(volume_id)
          response = Excon::Response.new
          if list_volumes.body['volumes'].map { |v| v['id'] }.include? volume_id
            data[:volumes].delete(volume_id)
            response.status = 204
            response
          else
            raise Fog::Compute::TeleFonica::NotFound
          end
        end
      end
    end
  end
end
