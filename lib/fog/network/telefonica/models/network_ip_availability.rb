require 'fog/telefonica/models/model'

module Fog
  module Network
    class TeleFonica
      class NetworkIpAvailability < Fog::TeleFonica::Model
        attribute :used_ips
        attribute :subnet_ip_availability
        attribute :network_id
        attribute :project_id
        attribute :tenant_id
        attribute :total_ips
        attribute :network_name
      end
    end
  end
end
