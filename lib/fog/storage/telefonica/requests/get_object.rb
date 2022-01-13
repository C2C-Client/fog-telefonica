module Fog
  module Storage
    class TeleFonica
      class Real
        # Get details for object
        #
        # ==== Parameters
        # * container<~String> - Name of container to look in
        # * object<~String> - Name of object to look for
        #
        def get_object(container, object, &block)
          params = {
            :expects => 200,
            :method  => 'GET',
            :path    => "#{Fog::TeleFonica.escape(container)}/#{Fog::TeleFonica.escape(object)}"
          }

          if block_given?
            params[:response_block] = block
          end

          request(params, false)
        end
      end
    end
  end
end
