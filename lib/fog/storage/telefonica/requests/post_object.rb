module Fog
  module Storage
    class TeleFonica
      class Real
        # Update object metadata
        #
        # ==== Parameters
        # * container<~String> - Name for container, should be < 256 bytes and must not contain '/'
        # * object<~String> - Name for object
        # * headers<~Hash> - metadata headers for object. Defaults to {}.
        #
        def post_object(container, object, headers = {})

          params = {
            :expects    => 202,
            :headers    => headers,
            :method     => 'POST',
            :path       => "#{Fog::TeleFonica.escape(container)}/#{Fog::TeleFonica.escape(object)}"
          }

          request(params)
        end
      end
    end
  end
end
