module Fog
  module Storage
    class TeleFonica
      class Real
        # Delete an existing container
        #
        # ==== Parameters
        # * name<~String> - Name of container to delete
        #
        def delete_container(name)
          request(
            :expects => 204,
            :method  => 'DELETE',
            :path    => Fog::TeleFonica.escape(name)
          )
        end
      end
    end
  end
end
