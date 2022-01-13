

module Fog
  module Image
    class TeleFonica < Fog::Service
      autoload :V1, 'fog/image/telefonica/v1'
      autoload :V2, 'fog/image/telefonica/v2'

      # Fog::Image::TeleFonica.new() will return a Fog::Image::TeleFonica::V2 or a Fog::Image::TeleFonica::V1,
      #  choosing the latest available
      def self.new(args = {})
        @telefonica_auth_uri = URI.parse(args[:telefonica_auth_url]) if args[:telefonica_auth_url]
        if inspect == 'Fog::Image::TeleFonica'
          service = Fog::Image::TeleFonica::V2.new(args) unless args.empty?
          service ||= Fog::Image::TeleFonica::V1.new(args)
        else
          service = Fog::Service.new(args)
        end
        service
      end
    end
  end
end
