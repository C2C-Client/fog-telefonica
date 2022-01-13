require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/lb_vip'

module Fog
  module Network
    class TeleFonica
      class LbVips < Fog::TeleFonica::Collection
        attribute :filters

        model Fog::Network::TeleFonica::LbVip

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_lb_vips(filters), 'vips')
        end

        def get(vip_id)
          if vip = service.get_lb_vip(vip_id).body['vip']
            new(vip)
          end
        rescue Fog::Network::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
