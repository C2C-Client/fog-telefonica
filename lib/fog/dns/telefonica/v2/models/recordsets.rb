require 'fog/telefonica/models/collection'
require 'fog/dns/telefonica/v2/models/recordset'

module Fog
  module DNS
    class TeleFonica
      class V2
        class Recordsets < Fog::TeleFonica::Collection
          model Fog::DNS::TeleFonica::V2::Recordset

          def all(options = {})
            load_response(service.list_recordsets(options), 'recordsets')
          end

          def find_by_id(zone_id, id, options = {})
            recordset_hash = service.get_recordset(zone_id, id, options).body
            new(recordset_hash.merge(:service => service))
          end

          alias get find_by_id

          def destroy(zone_id, id, options = {})
            recordset = find_by_id(zone_id, id, options)
            recordset.destroy
          end
        end
      end
    end
  end
end
