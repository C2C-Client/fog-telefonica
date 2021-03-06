require 'fog/telefonica/models/model'

module Fog
  module Compute
    class TeleFonica
      class ServerGroup < Fog::TeleFonica::Model
        identity  :id
        attribute :name
        attribute :policies, :type => :array
        attribute :members

        VALID_SERVER_GROUP_POLICIES = ['affinity', 'anti-affinity', 'soft-affinity', 'soft-anti-affinity'].freeze

        def self.validate_server_group_policy(policy)
          raise ArgumentError, "#{policy} is an invalid policy... must use one of #{VALID_SERVER_GROUP_POLICIES.join(', ')}" \
            unless VALID_SERVER_GROUP_POLICIES.include? policy
          true
        end
      end
    end
  end
end
