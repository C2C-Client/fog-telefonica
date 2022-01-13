require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/network'

module Fog
  module Compute
    class TeleFonica
      class Networks < Fog::TeleFonica::Collection
        model Fog::Compute::TeleFonica::Network

        attribute :server

        def all
          requires :server

          networks = []
          server.addresses.each_with_index do |address, index|
            networks << {
              :id        => index + 1,
              :name      => address[0],
              :addresses => address[1].map { |a| a['addr'] }
            }
          end

          # TODO: convert to load_response?
          load(networks)
        end
      end
    end
  end
end
