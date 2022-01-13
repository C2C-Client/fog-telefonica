require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/host'

module Fog
  module Compute
    class TeleFonica
      class Hosts < Fog::TeleFonica::Collection
        model Fog::Compute::TeleFonica::Host

        def all(options = {})
          data = service.list_hosts(options)
          load_response(data, 'hosts')
        end

        def get(host_name)
          if host = service.get_host_details(host_name).body['host']
            new('host_name' => host_name,
                'details'   => host)
          end
        rescue Fog::Compute::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
