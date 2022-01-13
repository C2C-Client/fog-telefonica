module Fog
  module Workflow
    class TeleFonica < Fog::Service
      # Fog::Workflow::TeleFonica.new() will return a Fog::Workflow::TeleFonica::V2
      #  Will choose the latest available once Mistral V3 is released.
      def self.new(args = {})
        @telefonica_auth_uri = URI.parse(args[:telefonica_auth_url]) if args[:telefonica_auth_url]
        Fog::Workflow::TeleFonica::V2.new(args)
      end
    end
  end
end
