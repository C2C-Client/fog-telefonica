require 'fog/telefonica/auth/catalog'

module Fog
  module TeleFonica
    module Auth
      module Catalog
        class V3
          include Fog::TeleFonica::Auth::Catalog

          def endpoint_match?(endpoint, interface, region)
            if endpoint['interface'] == interface
              true unless !region.nil? && endpoint['region'] != region
            end
          end

          def endpoint_url(endpoint, _)
            endpoint['url']
          end
        end
      end
    end
  end
end
