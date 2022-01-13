require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/tenant'

module Fog
  module Compute
    class TeleFonica
      class Tenants < Fog::TeleFonica::Collection
        model Fog::Compute::TeleFonica::Tenant

        def all
          load_response(service.list_tenants, 'tenants')
        end

        def usages(start_date = nil, end_date = nil, details = false)
          service.list_usages(start_date, end_date, details).body['tenant_usages']
        end

        def get(id)
          find { |tenant| tenant.id == id }
        end
      end
    end
  end
end
