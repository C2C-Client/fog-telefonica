module Fog
  module Image
    class TeleFonica
      class V1
        class Real
          def list_public_images_detailed(options = {}, query_deprecated = nil)
            if options.kind_of?(Hash)
              query = options
            elsif options
              Fog::Logger.deprecation("Calling TeleFonica[:glance].list_public_images_detailed(attribute, query) format"\
                                    " is deprecated, call .list_public_images_detailed(attribute => query) instead")
              query = {options => query_deprecated}
            else
              query = {}
            end

            request(
              :expects => [200, 204],
              :method  => 'GET',
              :path    => 'images/detail',
              :query   => query
            )
          end
        end

        class Mock
          def list_public_images_detailed(_options = {}, _query_deprecated = nil)
            response = Excon::Response.new
            response.status = [200, 204][rand(2)]
            response.body = {'images' => data[:images].values}
            response
          end
        end
      end
    end
  end
end
