require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/os_interface'

module Fog
  module Compute
    class TeleFonica
      class OsInterfaces < Fog::TeleFonica::Collection
        model Fog::Compute::TeleFonica::OsInterface

        attribute :server

        def all
          requires :server

          data = service.list_os_interfaces(server.id)
          load_response(data, 'interfaceAttachments')
        end

        def get(port_id)
          requires :server

          data = service.get_os_interface(server.id,port_id)
          load_response(data, 'interfaceAttachment')
        end
      end
    end
  end
end
