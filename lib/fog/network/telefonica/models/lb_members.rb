require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/lb_member'

module Fog
  module Network
    class TeleFonica
      class LbMembers < Fog::TeleFonica::Collection
        attribute :filters

        model Fog::Network::TeleFonica::LbMember

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_lb_members(filters), 'members')
        end

        def get(member_id)
          if member = service.get_lb_member(member_id).body['member']
            new(member)
          end
        rescue Fog::Network::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
