require 'fog/workflow/telefonica'

module Fog
  module Workflow
    class TeleFonica
      class V2 < Fog::Service
        SUPPORTED_VERSIONS = /v2/

        requires :telefonica_auth_url
        recognizes :telefonica_username, :telefonica_api_key,
                   :telefonica_project_name, :telefonica_domain_id

        ## REQUESTS
        #
        request_path 'fog/workflow/telefonica/v2/requests'

        # Workflow requests
        request :create_execution
        request :get_execution
        request :list_executions
        request :update_execution
        request :delete_execution

        request :create_action_execution
        request :get_action_execution
        request :list_action_executions
        request :update_action_execution
        request :delete_action_execution

        request :create_workbook
        request :get_workbook
        request :list_workbooks
        request :update_workbook
        request :validate_workbook
        request :delete_workbook

        request :create_workflow
        request :get_workflow
        request :list_workflows
        request :update_workflow
        request :validate_workflow
        request :delete_workflow

        request :create_action
        request :get_action
        request :list_actions
        request :update_action
        request :validate_action
        request :delete_action

        request :get_task
        request :list_tasks
        request :rerun_task

        request :create_cron_trigger
        request :get_cron_trigger
        request :list_cron_triggers
        request :delete_cron_trigger

        request :create_environment
        request :get_environment
        request :list_environments
        request :update_environment
        request :delete_environment

        request :list_services

        class Mock
          def self.data
            @data ||= Hash.new do |hash, key|
              hash[key] = {
                :workflows => {}
              }
            end
          end

          def self.reset
            @data = nil
          end

          include Fog::TeleFonica::Core

          def initialize(options = {})
            @auth_token = Fog::Mock.random_base64(64)
            @auth_token_expiration = (Time.now.utc + 86_400).iso8601
          end

          def data
            self.class.data[@telefonica_username]
          end

          def reset_data
            self.class.data.delete(@telefonica_username)
          end
        end

        class Real
          include Fog::TeleFonica::Core

          def default_path_prefix
            'v2'
          end

          def default_service_type
            %w[workflowv2]
          end

          def request(params)
            response = @connection.request(
              params.merge(
                :headers => {
                  'Content-Type' => 'application/json',
                  'X-Auth-Token' => @auth_token
                }.merge!(params[:headers] || {}),
                :path    => "#{@path}/#{params[:path]}"
              )
            )
          rescue Excon::Errors::Unauthorized    => error
            if error.response.body != "Bad username or password" # token expiration
              @telefonica_must_reauthenticate = true
              authenticate
              retry
            else # bad credentials
              raise error
            end
          rescue Excon::Errors::HTTPStatusError => error
            raise case error
                  when Excon::Errors::NotFound
                    Fog::Workflow::TeleFonica::NotFound.slurp(error)
                  else
                    error
                  end
          else
            unless response.body.empty?
              response.body = Fog::JSON.decode(response.body)
            end
            response
          end
        end
      end
    end
  end
end
