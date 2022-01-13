require 'fog/telefonica/models/model'

module Fog
  module DNS
    class TeleFonica
      class V2
        class Pool < Fog::TeleFonica::Model
          identity :id

          attribute :name
          attribute :description
          attribute :ns_records
          attribute :project_id
          attribute :links
          attribute :created_at
          attribute :updated_at
        end
      end
    end
  end
end
