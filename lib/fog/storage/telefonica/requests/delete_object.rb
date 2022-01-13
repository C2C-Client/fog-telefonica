module Fog
  module Storage
    class TeleFonica
      class Real
        # Delete an existing object
        #
        # ==== Parameters
        # * container<~String> - Name of container to delete
        # * object<~String> - Name of object to delete
        #
        def delete_object(container, object)
          request(
            :expects => 204,
            :method  => 'DELETE',
            :path    => "#{Fog::TeleFonica.escape(container)}/#{Fog::TeleFonica.escape(object)}"
          )
        end
      end
    end
  end
end
