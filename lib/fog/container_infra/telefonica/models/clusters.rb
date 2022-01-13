require 'fog/telefonica/models/collection'
require 'fog/container_infra/telefonica/models/cluster'

module Fog
  module ContainerInfra
    class TeleFonica
      class Clusters < Fog::TeleFonica::Collection

        model Fog::ContainerInfra::TeleFonica::Cluster

        def all
          load_response(service.list_clusters, "clusters")
        end

        def get(cluster_uuid_or_name)
          resource = service.get_cluster(cluster_uuid_or_name).body
          new(resource)
        rescue Fog::ContainerInfra::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
