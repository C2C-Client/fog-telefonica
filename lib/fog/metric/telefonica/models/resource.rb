require 'fog/telefonica/models/model'

module Fog
  module Metric
    class TeleFonica
      class Resource < Fog::TeleFonica::Model
        identity :id

        attribute :original_resource_id
        attribute :project_id
        attribute :user_id
        attribute :metrics
      end
    end
  end
end
