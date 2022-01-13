module Fog
  module TeleFonica
    module Core
      attr_accessor :auth_token
      attr_reader :unscoped_token
      attr_reader :telefonica_cache_ttl
      attr_reader :auth_token_expiration
      attr_reader :current_user
      attr_reader :current_user_id
      attr_reader :current_tenant
      attr_reader :telefonica_domain_name
      attr_reader :telefonica_user_domain
      attr_reader :telefonica_project_domain
      attr_reader :telefonica_domain_id
      attr_reader :telefonica_user_domain_id
      attr_reader :telefonica_project_id
      attr_reader :telefonica_project_domain_id
      attr_reader :telefonica_identity_api_version

      # fallback
      def self.not_found_class
        Fog::Compute::TeleFonica::NotFound
      end

      def credentials
        options = {
          :provider             => 'telefonica',
          :telefonica_auth_url   => @telefonica_auth_uri.to_s,
          :telefonica_auth_token => @auth_token,
          :current_user         => @current_user,
          :current_user_id      => @current_user_id,
          :current_tenant       => @current_tenant,
          :unscoped_token       => @unscoped_token
        }
        telefonica_options.merge options
      end

      def reload
        @connection.reset
      end

      def initialize(options = {})
        setup(options)
        authenticate
        @connection = Fog::Core::Connection.new(@telefonica_management_url, @persistent, @connection_options)
      end

      private

      def request(params, parse_json = true)
        retried = false
        begin
          response = @connection.request(
            params.merge(
              :headers => headers(params.delete(:headers)),
              :path    => "#{@path}/#{params[:path]}"
            )
          )
        rescue Excon::Errors::Unauthorized => error
          # token expiration and token renewal possible
          if error.response.body != 'Bad username or password' && @telefonica_can_reauthenticate && !retried
            @telefonica_must_reauthenticate = true
            authenticate
            retried = true
            retry
          # bad credentials or token renewal not possible
          else
            raise error
          end
        rescue Excon::Errors::HTTPStatusError => error
          raise case error
                when Excon::Errors::NotFound
                  self.class.not_found_class.slurp(error)
                else
                  error
                end
        end

        if !response.body.empty? && response.get_header('Content-Type').match('application/json')
          # TODO: remove parse_json in favor of :raw_body
          response.body = Fog::JSON.decode(response.body) if parse_json && !params[:raw_body]
        end

        response
      end

      def set_microversion
        @microversion_key          ||= 'Telefonica-API-Version'.freeze
        @microversion_service_type ||= @telefonica_service_type.first

        @microversion = Fog::TeleFonica.get_supported_microversion(
          @supported_versions,
          @telefonica_management_uri,
          @auth_token,
          @connection_options
        ).to_s

        # choose minimum out of reported and supported version
        if microversion_newer_than?(@supported_microversion)
          @microversion = @supported_microversion
        end

        # choose minimum out of set and wished version
        if @fixed_microversion && microversion_newer_than?(@fixed_microversion)
          @microversion = @fixed_microversion
        elsif @fixed_microversion && @microversion != @fixed_microversion
          Fog::Logger.warning("Microversion #{@fixed_microversion} not supported")
        end
      end

      def microversion_newer_than?(version)
        Gem::Version.new(version) < Gem::Version.new(@microversion)
      end

      def headers(additional_headers)
        additional_headers ||= {}
        unless @microversion.nil? || @microversion.empty?
          microversion_value = if @microversion_key == 'Telefonica-API-Version'
                                 "#{@microversion_service_type} #{@microversion}"
                               else
                                 @microversion
                               end
          microversion_header = {@microversion_key => microversion_value}
          additional_headers.merge!(microversion_header)
        end

        {
          'Content-Type' => 'application/json',
          'Accept'       => 'application/json',
          'X-Auth-Token' => @auth_token
        }.merge!(additional_headers)
      end

      def telefonica_options
        options = {}
        # Create a hash of (:telefonica_*, value) of all the @telefonica_* instance variables
        instance_variables.select { |x| x.to_s.start_with? '@telefonica' }.each do |telefonica_param|
          option_name = telefonica_param.to_s[1..-1]
          options[option_name.to_sym] = instance_variable_get telefonica_param
        end
        options
      end

      def api_path_prefix
        path = ''
        if @telefonica_management_uri && @telefonica_management_uri.path != '/'
          path = @telefonica_management_uri.path
        end
        unless default_path_prefix.empty?
          path << '/' + default_path_prefix
        end
        path
      end

      def default_endpoint_type
        'public'
      end

      def default_path_prefix
        ''
      end

      def setup(options)
        if options.respond_to?(:config_service?) && options.config_service?
          configure(options)
          return
        end

        # Create @telefonica_* instance variables from all :telefonica_* options
        options.select { |x| x.to_s.start_with? 'telefonica' }.each do |telefonica_param, value|
          instance_variable_set "@#{telefonica_param}".to_sym, value
        end

        @auth_token ||= options[:telefonica_auth_token]
        @telefonica_must_reauthenticate = false
        @telefonica_endpoint_type = options[:telefonica_endpoint_type] || 'public'
        @telefonica_cache_ttl = options[:telefonica_cache_ttl] || 0

        if @auth_token
          @telefonica_can_reauthenticate = false
        else
          missing_credentials = []

          missing_credentials << :telefonica_api_key unless @telefonica_api_key
          unless @telefonica_username || @telefonica_userid
            missing_credentials << 'telefonica_username or telefonica_userid'
          end
          unless missing_credentials.empty?
            raise ArgumentError, "Missing required arguments: #{missing_credentials.join(', ')}"
          end
          @telefonica_can_reauthenticate = true
        end

        @current_user    = options[:current_user]
        @current_user_id = options[:current_user_id]
        @current_tenant  = options[:current_tenant]

        @telefonica_service_type = options[:telefonica_service_type] || default_service_type
        @telefonica_endpoint_type = options[:telefonica_endpoint_type] || default_endpoint_type
        @telefonica_endpoint_type.gsub!(/URL/, '')
        @connection_options = options[:connection_options] || {}
        @persistent = options[:persistent] || false
      end

      def authenticate
        if !@telefonica_management_url || @telefonica_must_reauthenticate
          @telefonica_auth_token = nil if @telefonica_must_reauthenticate

          token = Fog::TeleFonica::Auth::Token.build(telefonica_options, @connection_options)

          @telefonica_management_url = if token.catalog && !token.catalog.payload.empty?
                                        token.catalog.get_endpoint_url(
                                          @telefonica_service_type,
                                          @telefonica_endpoint_type,
                                          @telefonica_region
                                        )
                                      else
                                        @telefonica_auth_url
                                      end

          @current_user = token.user['name']
          @current_user_id          = token.user['id']
          @current_tenant           = token.tenant
          @expires                  = token.expires
          @auth_token               = token.token
          @unscoped_token           = token.token
          @telefonica_must_reauthenticate = false
        else
          @auth_token = @telefonica_auth_token
        end

        @telefonica_management_uri = URI.parse(@telefonica_management_url)

        # both need to be set in service's initialize for microversions to work
        set_microversion if @supported_microversion && @supported_versions
        @path = api_path_prefix

        true
      end
    end
  end
end
