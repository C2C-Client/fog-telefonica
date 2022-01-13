require 'fog/telefonica/models/model'

module Fog
  module Network
    class TeleFonica
      class Extension < Fog::TeleFonica::Model
        identity :id
        attribute :name
        attribute :links
        attribute :description
        attribute :alias
      end
    end
  end
end
