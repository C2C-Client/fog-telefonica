require 'fog/telefonica/auth/catalog'

module Fog
  module TeleFonica
    module Auth
      module Catalog
        class V2
          include Fog::TeleFonica::Auth::Catalog

          def endpoint_match?(endpoint, interface, region)
            if endpoint.key?("#{interface}URL")
              true unless !region.nil? && endpoint['region'] != region
            end
          end

          def endpoint_url(endpoint, interface)
            endpoint["#{interface}URL"]
          end
        end
      end
    end
  end
end
