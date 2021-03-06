module Fog
  module Workflow
    class TeleFonica
      class V2
        class Real
          def get_workbook(name)
            request(
              :expects => 200,
              :method  => "GET",
              :path    => "workbooks/#{URI.encode(name)}"
            )
          end
        end

        class Mock
          def get_workbook(_name)
            response = Excon::Response.new
            response.status = 200
            response.body = {"version"     => "2.0",
                             "name"        => "workbook1",
                             "description" => "d1"}
            response
          end
        end
      end
    end
  end
end
