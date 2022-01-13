require 'fog/telefonica/models/model'

module Fog
  module Compute
    class TeleFonica
      class Network < Fog::TeleFonica::Model
        identity  :id
        attribute :name
        attribute :addresses
      end
    end
  end
end
