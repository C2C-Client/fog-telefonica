require 'fog/core'
require 'fog/json'

module Fog
  # Monkey patch to reflect https://github.com/fog/fog-core/commit/06b7ab4
  # needed because fog-core 2.1.1+ implies entire namespace change
  # is only availabe from fog-telefonica 1.0.0+
  module Attributes
    module InstanceMethods
      def all_attributes
        self.class.attributes.reduce({}) do |hash, attribute|
          if masks[attribute].nil?
            Fog::Logger.deprecation("Please define #{attribute} using the Fog DSL")
            hash[attribute] = send(attribute)
          else
            hash[masks[attribute]] = send(attribute)
          end

          hash
        end
      end

      def all_associations
        self.class.associations.keys.reduce({}) do |hash, association|
          if masks[association].nil?
            Fog::Logger.deprecation("Please define #{association} using the Fog DSL")
            hash[association] = associations[association] || send(association)
          else
            hash[masks[association]] = associations[association] || send(association)
          end

          hash
        end
      end
    end
  end

  module Baremetal
    autoload :TeleFonica, 'fog/baremetal/telefonica'
  end

  module Compute
    autoload :TeleFonica, 'fog/compute/telefonica'
  end

  module ContainerInfra
    autoload :TeleFonica, 'fog/container_infra/telefonica'
  end

  module DNS
    autoload :TeleFonica, 'fog/dns/telefonica'
  end

  module Event
    autoload :TeleFonica, 'fog/event/telefonica'
  end

  module Identity
    autoload :TeleFonica, 'fog/identity/telefonica'
  end

  module Image
    autoload :TeleFonica, 'fog/image/telefonica'
  end

  module Introspection
    autoload :TeleFonica, 'fog/introspection/telefonica'
  end

  module KeyManager
    autoload :TeleFonica, 'fog/key_manager/telefonica'
  end

  module Metering
    autoload :TeleFonica, 'fog/metering/telefonica'
  end

  module Metric
    autoload :TeleFonica, 'fog/metric/telefonica'
  end

  module Monitoring
    autoload :TeleFonica, 'fog/monitoring/telefonica'
  end

  module Network
    autoload :TeleFonica, 'fog/network/telefonica'
  end

  module NFV
    autoload :TeleFonica, 'fog/nfv/telefonica'
  end

  module Orchestration
    autoload :TeleFonica, 'fog/orchestration/telefonica'
    autoload :Util, 'fog/orchestration/util/recursive_hot_file_loader'
  end

  module SharedFileSystem
    autoload :TeleFonica, 'fog/shared_file_system/telefonica'
  end

  module Storage
    autoload :TeleFonica, 'fog/storage/telefonica'
  end

  module Volume
    autoload :TeleFonica, 'fog/volume/telefonica'
  end

  module Workflow
    autoload :TeleFonica, 'fog/workflow/telefonica'

    class TeleFonica
      autoload :V2, 'fog/workflow/telefonica/v2'
    end
  end

  module TeleFonica
    require 'fog/telefonica/auth/token'

    autoload :VERSION, 'fog/telefonica/version'

    autoload :Core, 'fog/telefonica/core'
    autoload :Errors, 'fog/telefonica/errors'
    autoload :Planning, 'fog/planning/telefonica'

    extend Fog::Provider

    service(:baremetal,          'Baremetal')
    service(:compute,            'Compute')
    service(:container_infra,    'ContainerInfra')
    service(:dns,                'DNS')
    service(:event,              'Event')
    service(:identity,           'Identity')
    service(:image,              'Image')
    service(:introspection,      'Introspection')
    service(:key,                'KeyManager')
    service(:metering,           'Metering')
    service(:metric,             'Metric')
    service(:monitoring,         'Monitoring')
    service(:network,            'Network')
    service(:nfv,                'NFV')
    service(:orchestration,      'Orchestration')
    service(:planning,           'Planning')
    service(:shared_file_system, 'SharedFileSystem')
    service(:storage,            'Storage')
    service(:volume,             'Volume')
    service(:workflow,           'Workflow')

    @token_cache = {}

    class << self
      attr_accessor :token_cache
    end

    def self.clear_token_cache
      Fog::TeleFonica.token_cache = {}
    end

    def self.endpoint_region?(endpoint, region)
      region.nil? || endpoint['region'] == region
    end

    def self.get_supported_version(supported_versions, uri, auth_token, connection_options = {})
      supported_version = get_version(supported_versions, uri, auth_token, connection_options)
      version = supported_version['id'] if supported_version
      version_raise(supported_versions) if version.nil?

      version
    end

    def self.get_supported_version_path(supported_versions, uri, auth_token, connection_options = {})
      supported_version = get_version(supported_versions, uri, auth_token, connection_options)
      link = supported_version['links'].find { |l| l['rel'] == 'self' } if supported_version
      path = URI.parse(link['href']).path if link
      version_raise(supported_versions) if path.nil?

      path.chomp '/'
    end

    def self.get_supported_microversion(supported_versions, uri, auth_token, connection_options = {})
      supported_version = get_version(supported_versions, uri, auth_token, connection_options)
      supported_version['version'] if supported_version
    end

    # CGI.escape, but without special treatment on spaces
    def self.escape(str, extra_exclude_chars = '')
      str.gsub(/([^a-zA-Z0-9_.-#{extra_exclude_chars}]+)/) do
        '%' + $1.unpack('H2' * $1.bytesize).join('%').upcase
      end
    end

    def self.get_version(supported_versions, uri, auth_token, connection_options = {})
      version_cache = "#{uri}#{supported_versions}"
      return @version[version_cache] if @version && @version[version_cache]

      # To allow version discovery we need a "version less" endpoint
      path = uri.path.gsub(/\/v([1-9]+\d*)(\.[1-9]+\d*)*.*$/, '/')
      url = "#{uri.scheme}://#{uri.host}:#{uri.port}#{path}"
      connection = Fog::Core::Connection.new(url, false, connection_options)
      response = connection.request(
        :expects => [200, 204, 300],
        :headers => {'Content-Type' => 'application/json',
                     'Accept'       => 'application/json',
                     'X-Auth-Token' => auth_token},
        :method  => 'GET'
      )

      body = Fog::JSON.decode(response.body)

      @version                = {} unless @version
      @version[version_cache] = extract_version_from_body(body, supported_versions)
    end

    def self.extract_version_from_body(body, supported_versions)
      versions = []
      unless body['versions'].nil? || body['versions'].empty?
        versions = body['versions'].kind_of?(Array) ? body['versions'] : body['versions']['values']
      end
      # Some version API would return single endpoint rather than endpoints list, try to get it via 'version'.
      unless body['version'].nil? or versions.length != 0
        versions = [body['version']]
      end
      version = nil

      # order is important, preferred status should be first
      %w(CURRENT stable SUPPORTED DEPRECATED).each do |status|
        version = versions.find { |x| x['id'].match(supported_versions) && (x['status'] == status) }
        break if version
      end

      version
    end

    def self.version_raise(supported_versions)
      raise Fog::TeleFonica::Errors::ServiceUnavailable,
            "TeleFonica service only supports API versions #{supported_versions.inspect}"
    end
  end
end
