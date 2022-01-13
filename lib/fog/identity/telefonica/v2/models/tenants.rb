require 'fog/telefonica/models/collection'
require 'fog/identity/telefonica/v2/models/tenant'

module Fog
  module Identity
    class TeleFonica
      class V2
        class Tenants < Fog::TeleFonica::Collection
          model Fog::Identity::TeleFonica::V2::Tenant

          def all(options = {})
            load_response(service.list_tenants(options), 'tenants')
          end

          def find_by_id(id)
            cached_tenant = find { |tenant| tenant.id == id }
            return cached_tenant if cached_tenant
            tenant_hash = service.get_tenant(id).body['tenant']
            Fog::Identity::TeleFonica::V2::Tenant.new(
              tenant_hash.merge(:service => service)
            )
          end

          def destroy(id)
            tenant = find_by_id(id)
            tenant.destroy
          end
        end
      end
    end
  end
end
