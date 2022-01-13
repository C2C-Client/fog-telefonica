require 'fog/telefonica/models/model'

module Fog
  module Compute
    class TeleFonica
      class OsInterface < Fog::TeleFonica::Model
        identity  :port_id
        attribute :fixed_ips, :type => :array
        attribute :mac_addr
        attribute :net_id
        attribute :port_state
      end
    end
  end
end
