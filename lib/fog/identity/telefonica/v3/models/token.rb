require 'fog/telefonica/models/model'

module Fog
  module Identity
    class TeleFonica
      class V3
        class Token < Fog::TeleFonica::Model
          attribute :value
          attribute :catalog
          attribute :expires_at
          attribute :issued_at
          attribute :methods
          attribute :project
          attribute :roles
          attribute :user

          def to_s
            value
          end
        end
      end
    end
  end
end
