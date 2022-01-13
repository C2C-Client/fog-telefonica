require 'fog/telefonica/auth/token/v2'
require 'fog/telefonica/auth/token/v3'
require 'fog/telefonica/auth/catalog/v2'
require 'fog/telefonica/auth/catalog/v3'

module Fog
  module TeleFonica
    module Auth
      module Token
        attr_reader :catalog, :expires, :tenant, :token, :user, :data

        class ExpiryError < RuntimeError; end
        class StandardError < RuntimeError; end
        class URLError < RuntimeError; end

        def self.build(auth, options)
          if auth[:telefonica_identity_api_version] =~ /(v)*2(\.0)*/i ||
             auth[:telefonica_tenant_id] || auth[:telefonica_tenant]
            Fog::TeleFonica::Auth::Token::V2.new(auth, options)
          else
            Fog::TeleFonica::Auth::Token::V3.new(auth, options)
          end
        end

        def initialize(auth, options)
          raise URLError, 'No URL provided' if auth[:telefonica_auth_url].nil? || auth[:telefonica_auth_url].empty?
          @creds = {
            :data => build_credentials(auth),
            :uri  => URI.parse(auth[:telefonica_auth_url])
          }
          response = authenticate(@creds, options)
          set(response)
        end

        def get
          set(authenticate(@creds, {})) if expired?
          @token
        end

        private

        def authenticate(creds, options)
          connection = Fog::Core::Connection.new(creds[:uri].to_s, false, options)

          request = {
            :expects => [200, 201],
            :headers => {'Content-Type' => 'application/json'},
            :body    => Fog::JSON.encode(creds[:data]),
            :method  => 'POST',
            :path    => creds[:uri].path + prefix_path(creds[:uri]) + path
          }

          connection.request(request)
        end

        def expired?
          if @expires.nil? || @expires.empty?
            raise ExpiryError, 'Missing token expiration data'
          end
          Time.parse(@expires) < Time.now.utc
        end

        def refresh
          raise StandardError, "__method__ not implemented yet!"
        end
      end
    end
  end
end
