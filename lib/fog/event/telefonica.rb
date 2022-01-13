module Fog
  module Event
    class TeleFonica < Fog::Service
      SUPPORTED_VERSIONS = /v2/

      requires :telefonica_auth_url
      recognizes :telefonica_auth_token, :telefonica_management_url,
                 :persistent, :telefonica_service_type, :telefonica_service_name,
                 :telefonica_tenant, :telefonica_tenant_id,
                 :telefonica_api_key, :telefonica_username, :telefonica_identity_endpoint,
                 :current_user, :current_tenant, :telefonica_region,
                 :telefonica_endpoint_type, :telefonica_cache_ttl,
                 :telefonica_project_name, :telefonica_project_id,
                 :telefonica_project_domain, :telefonica_user_domain, :telefonica_domain_name,
                 :telefonica_project_domain_id, :telefonica_user_domain_id, :telefonica_domain_id,
                 :telefonica_identity_api_version

      model_path 'fog/event/telefonica/models'

      model       :event
      collection  :events

      request_path 'fog/event/telefonica/requests'

      request :get_event
      request :list_events

      class Mock
        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {
              :users   => {},
              :tenants => {}
            }
          end
        end

        def self.reset
          @data = nil
        end

        def initialize(options = {})
          @telefonica_username = options[:telefonica_username]
          @telefonica_tenant   = options[:telefonica_tenant]
          @telefonica_auth_uri = URI.parse(options[:telefonica_auth_url])

          @auth_token = Fog::Mock.random_base64(64)
          @auth_token_expiration = (Time.now.utc + 86400).iso8601

          management_url = URI.parse(options[:telefonica_auth_url])
          management_url.port = 8779
          management_url.path = '/v2'
          @telefonica_management_url = management_url.to_s

          @data ||= {:users => {}}
          unless @data[:users].find { |u| u['name'] == options[:telefonica_username] }
            id = Fog::Mock.random_numbers(6).to_s
            @data[:users][id] = {
              'id'       => id,
              'name'     => options[:telefonica_username],
              'email'    => "#{options[:telefonica_username]}@mock.com",
              'tenantId' => Fog::Mock.random_numbers(6).to_s,
              'enabled'  => true
            }
          end
        end

        def data
          self.class.data[@telefonica_username]
        end

        def reset_data
          self.class.data.delete(@telefonica_username)
        end

        def credentials
          {:provider                 => 'telefonica',
           :telefonica_auth_url       => @telefonica_auth_uri.to_s,
           :telefonica_auth_token     => @auth_token,
           :telefonica_management_url => @telefonica_management_url}
        end
      end

      class Real
        include Fog::TeleFonica::Core

        def self.not_found_class
          Fog::Event::TeleFonica::NotFound
        end

        def default_path_prefix
          'v2'
        end

        def default_service_type
          %w[event]
        end
      end
    end
  end
end
