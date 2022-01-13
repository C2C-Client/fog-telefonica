module Fog
  module DNS
    class TeleFonica < Fog::Service
      autoload :V1, 'fog/dns/telefonica/v1'
      autoload :V2, 'fog/dns/telefonica/v2'

      # Fog::DNS::TeleFonica.new() will return a Fog::DNS::TeleFonica::V2 or a Fog::DNS::TeleFonica::V1,
      # choosing the latest available
      def self.new(args = {})
        @telefonica_auth_uri = URI.parse(args[:telefonica_auth_url]) if args[:telefonica_auth_url]
        if inspect == 'Fog::DNS::TeleFonica'
          service = Fog::DNS::TeleFonica::V2.new(args) unless args.empty?
          service ||= Fog::DNS::TeleFonica::V1.new(args)
        else
          service = Fog::Service.new(args)
        end
        service
      end
    end
  end
end
