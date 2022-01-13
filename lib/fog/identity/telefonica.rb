module Fog
  module Identity
    class TeleFonica < Fog::Service
      autoload :V2, 'fog/identity/telefonica/v2'
      autoload :V3, 'fog/identity/telefonica/v3'

      def self.new(args = {})
        if args[:telefonica_identity_api_version] =~ /(v)*2(\.0)*/i
          Fog::Identity::TeleFonica::V2.new(args)
        else
          Fog::Identity::TeleFonica::V3.new(args)
        end
      end

      class Mock
        attr_reader :config

        def initialize(options = {})
          @telefonica_auth_uri = URI.parse(options[:telefonica_auth_url])
          @config = options
        end
      end

      class Real
        include Fog::TeleFonica::Core

        def self.not_found_class
          Fog::Identity::TeleFonica::NotFound
        end

        def config_service?
          true
        end

        def config
          self
        end

        def default_endpoint_type
          'admin'
        end

        private

        def configure(source)
          source.instance_variables.each do |v|
            instance_variable_set(v, source.instance_variable_get(v))
          end
        end
      end
    end
  end
end
