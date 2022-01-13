require 'fog/telefonica/models/model'
require 'fog/storage/telefonica/models/files'

module Fog
  module Storage
    class TeleFonica
      class Directory < Fog::TeleFonica::Model
        identity  :key, :aliases => 'name'

        attribute :bytes, :aliases => 'X-Container-Bytes-Used'
        attribute :count, :aliases => 'X-Container-Object-Count'

        attr_writer :public

        def destroy
          requires :key
          service.delete_container(key)
          true
        rescue Excon::Errors::NotFound
          false
        end

        def files
          @files ||= begin
            Fog::Storage::TeleFonica::Files.new(
              :directory => self,
              :service   => service
            )
          end
        end

        def public_url
          requires :key

          @public_url ||= begin
            service.public_url(key)
          rescue Fog::Storage::TeleFonica::NotFound => err
            nil
          end
        end

        def save
          requires :key
          service.put_container(key, :public => @public)
          true
        end
      end
    end
  end
end
