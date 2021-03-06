require 'fog/volume/telefonica/requests/list_volumes'

module Fog
  module Volume
    class TeleFonica
      class V2
        class Real
          include Fog::Volume::TeleFonica::Real
        end

        class Mock
          def list_volumes(_options = true, _options_deprecated = {})
            response            = Excon::Response.new
            response.status     = 200
            data[:volumes] ||= [
              {"status"            => "available",
               "description"       => "test 1 desc",
               "availability_zone" => "nova",
               "name"              => "Volume1",
               "attachments"       => [{}],
               "volume_type"       => nil,
               "snapshot_id"       => nil,
               "size"              => 1,
               "id"                => 1,
               "created_at"        => Time.now,
               "metadata"          => {}},
              {"status"            => "available",
               "description"       => "test 2 desc",
               "availability_zone" => "nova",
               "name"              => "Volume2",
               "attachments"       => [{}],
               "volume_type"       => nil,
               "snapshot_id"       => nil,
               "size"              => 1,
               "id"                => 2,
               "created_at"        => Time.now,
               "metadata"          => {}}
            ]
            response.body = {'volumes' => data[:volumes]}
            response
          end
        end
      end
    end
  end
end
