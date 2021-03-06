require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/network_ip_availability'

module Fog
  module Network
    class TeleFonica
      class NetworkIpAvailabilities < Fog::TeleFonica::Collection
        model Fog::Network::TeleFonica::NetworkIpAvailability

        def all
          load_response(service.list_network_ip_availabilities, 'network_ip_availabilities')
        end

        def get(network_id)
          if network_ip_availability = service.get_network_ip_availability(network_id).body['network_ip_availability']
            new(network_ip_availability)
          end
        rescue Fog::Network::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
