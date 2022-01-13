require 'fog/telefonica/auth/token'
require 'fog/telefonica/auth/name'

module Fog
  module TeleFonica
    module Auth
      module Token
        class V3
          include Fog::TeleFonica::Auth::Token
          attr_reader :domain, :project

          # Default Domain ID
          DOMAIN_ID = 'default'.freeze

          def credentials
            identity = if @token
                         {
                           'methods' => ['token'],
                           'token'   => {'id' => @token}
                         }
                       else
                         {
                           'methods'  => ['password'],
                           'password' => @user.identity
                         }
                       end

            if scope
              {
                'auth' => {
                  'identity' => identity,
                  'scope'    => scope
                }
              }
            else
              {'auth' => {'identity' => identity}}
            end
          end

          def prefix_path(uri)
            if uri.path =~ /\/v3(\/)*.*$/
              ''
            else
              '/v3'
            end
          end

          def path
            '/auth/tokens'
          end

          def scope
            return @project.identity if @project
            return @domain.identity if @domain
          end

          def set(response)
            @data = Fog::JSON.decode(response.body)
            @token = response.headers['x-subject-token']
            @expires = @data['token']['expires_at']
            @tenant = @data['token']['project']
            @user = @data['token']['user']
            catalog = @data['token']['catalog']
            if catalog
              @catalog = Fog::TeleFonica::Auth::Catalog::V3.new(catalog)
            end
          end

          def build_credentials(auth)
            if auth[:telefonica_project_id] || auth[:telefonica_project_name]
              # project scoped
              @project = Fog::TeleFonica::Auth::ProjectScope.new(
                auth[:telefonica_project_id],
                auth[:telefonica_project_name]
              )
              @project.domain = if auth[:telefonica_project_domain_id] || auth[:telefonica_project_domain_name]
                                  Fog::TeleFonica::Auth::Name.new(
                                    auth[:telefonica_project_domain_id],
                                    auth[:telefonica_project_domain_name]
                                  )
                                elsif auth[:telefonica_domain_id] || auth[:telefonica_domain_name]
                                  Fog::TeleFonica::Auth::Name.new(
                                    auth[:telefonica_domain_id],
                                    auth[:telefonica_domain_name]
                                  )
                                else
                                  Fog::TeleFonica::Auth::Name.new(DOMAIN_ID, nil)
                                end
            elsif auth[:telefonica_domain_id] || auth[:telefonica_domain_name]
              # domain scoped
              @domain = Fog::TeleFonica::Auth::DomainScope.new(
                auth[:telefonica_domain_id],
                auth[:telefonica_domain_name]
              )
            end

            if auth[:telefonica_auth_token]
              @token = auth[:telefonica_auth_token]
            else
              @user = Fog::TeleFonica::Auth::User.new(auth[:telefonica_userid], auth[:telefonica_username])
              @user.password = auth[:telefonica_api_key]

              @user.domain = if auth[:telefonica_user_domain_id] || auth[:telefonica_user_domain_name]
                               Fog::TeleFonica::Auth::Name.new(
                                 auth[:telefonica_user_domain_id],
                                 auth[:telefonica_user_domain_name]
                               )
                             elsif auth[:telefonica_domain_id] || auth[:telefonica_domain_name]
                               Fog::TeleFonica::Auth::Name.new(
                                 auth[:telefonica_domain_id],
                                 auth[:telefonica_domain_name]
                               )
                             else
                               Fog::TeleFonica::Auth::Name.new(DOMAIN_ID, nil)
                             end
            end

            credentials
          end
        end
      end
    end
  end
end
