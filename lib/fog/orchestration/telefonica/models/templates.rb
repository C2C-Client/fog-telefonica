require 'fog/telefonica/models/collection'
require 'fog/orchestration/telefonica/models/template'

module Fog
  module Orchestration
    class TeleFonica
      class Templates < Fog::TeleFonica::Collection
        model Fog::Orchestration::TeleFonica::Template

        def get(obj)
          data = if obj.kind_of?(Stack)
                   service.get_stack_template(obj).body
                 else
                   service.show_resource_template(obj.resource_name).body
                 end

          if data.key?('AWSTemplateFormatVersion')
            data['content'] = data.to_json
            data['format'] = 'CFN'
            data['template_version'] = data.delete('AWSTemplateFormatVersion')
            data['description'] = data.delete('Description')
            data['parameter'] = data.delete('Parameters')
            data['resources'] = data.delete('Resources')
          else
            data['content'] = data.to_yaml
            data['format'] = 'HOT'
            data['template_version'] = data.delete('heat_template_version')
          end

          new(data)
        rescue Fog::Orchestration::TeleFonica::NotFound
          nil
        end

        def validate(options = {})
          data = service.validate_template(options).body
          temp = new
          temp.parameters  = data['Parameters']
          temp.description = data['Description']
          temp
        end
      end
    end
  end
end
