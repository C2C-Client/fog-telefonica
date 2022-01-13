module Fog
  module Orchestration
    class TeleFonica
      class Real
        def validate_template(options = {})
          request(
            :body    => Fog::JSON.encode(options),
            :expects => [200],
            :method  => 'POST',
            :path    => 'validate'
          )
        end
      end
    end
  end
end
