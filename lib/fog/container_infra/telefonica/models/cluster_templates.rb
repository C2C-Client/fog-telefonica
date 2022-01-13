require 'fog/telefonica/models/collection'
require 'fog/container_infra/telefonica/models/cluster_template'

module Fog
  module ContainerInfra
    class TeleFonica
      class ClusterTemplates < Fog::TeleFonica::Collection

        model Fog::ContainerInfra::TeleFonica::ClusterTemplate

        def all
          load_response(service.list_cluster_templates, 'clustertemplates')
        end

        def get(cluster_template_uuid_or_name)
          resource = service.get_cluster_template(cluster_template_uuid_or_name).body
          new(resource)
        rescue Fog::ContainerInfra::TeleFonica::NotFound
          nil
        end
      end
    end
  end
end
