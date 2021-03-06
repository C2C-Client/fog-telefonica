require 'fog/telefonica/models/collection'
require 'fog/baremetal/telefonica/models/driver'

module Fog
  module Baremetal
    class TeleFonica
      class Drivers < Fog::TeleFonica::Collection
        model Fog::Baremetal::TeleFonica::Driver

        def all(options = {})
          load_response(service.list_drivers(options), 'drivers')
        end

        def find_by_name(name)
          new(service.get_driver(name).body)
        end
        alias get find_by_name
      end
    end
  end
end
