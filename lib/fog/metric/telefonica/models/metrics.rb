require 'fog/telefonica/models/collection'
require 'fog/metric/telefonica/models/metric'

module Fog
  module Metric
    class TeleFonica
      class Metrics < Fog::TeleFonica::Collection

        model Fog::Metric::TeleFonica::Metric

        def all(options = {})
          load_response(service.list_metrics(options))
        end

        def find_by_id(metric_id)
          resource = service.get_metric(metric_id).body
          new(resource)
        rescue Fog::Metric::TeleFonica::NotFound
          nil
        end

        def find_measures_by_id(metric_id, options = {})
          resource = service.get_metric_measures(metric_id, options).body
          new(resource)
        rescue Fog::Metric::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
