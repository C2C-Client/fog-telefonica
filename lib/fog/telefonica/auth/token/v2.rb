require 'fog/telefonica/auth/token'
require 'fog/telefonica/auth/name'

module Fog
  module TeleFonica
    module Auth
      module Token
        class CredentialsError < RuntimeError; end

        class V2
          include Fog::TeleFonica::Auth::Token
          attr_reader :tenant

          def credentials
            if @token
              identity = {'token' => {'id' => @token}}
            else
              raise CredentialsError, "#{self.class}: User name is required" if @user.name.nil?
              raise CredentialsError, "#{self.class}: User password is required" if @user.password.nil?
              identity = {'passwordCredentials' => user_credentials}
            end

            if @tenant.id
              identity['tenantId'] = @tenant.id.to_s
            elsif @tenant.name
              identity['tenantName'] = @tenant.name.to_s
            end

            {'auth' => identity}
          end

          def prefix_path(uri)
            if uri.path =~ /\/v2(\.0)*(\/)*.*$/
              ''
            else
              '/v2.0'
            end
          end

          def path
            '/tokens'
          end

          def user_credentials
            {
              'username' => @user.name.to_s,
              'password' => @user.password
            }
          end

          def set(response)
            @data = Fog::JSON.decode(response.body)
            @token   = @data['access']['token']['id']
            @expires = @data['access']['token']['expires']
            @tenant = @data['access']['token']['tenant']
            @user = @data['access']['user']
            catalog = @data['access']['serviceCatalog']
            @catalog = Fog::TeleFonica::Auth::Catalog::V2.new(catalog) if catalog
          end

          def build_credentials(auth)
            if auth[:telefonica_auth_token]
              @token = auth[:telefonica_auth_token]
            else
              @user = Fog::TeleFonica::Auth::User.new(auth[:telefonica_userid], auth[:telefonica_username])
              @user.password = auth[:telefonica_api_key]
            end

            @tenant = Fog::TeleFonica::Auth::Name.new(auth[:telefonica_tenant_id], auth[:telefonica_tenant])
            credentials
          end
        end
      end
    end
  end
end
