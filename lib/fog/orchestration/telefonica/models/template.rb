require 'fog/telefonica/models/model'

module Fog
  module Orchestration
    class TeleFonica
      class Template < Fog::TeleFonica::Model
        %w(format description template_version parameters resources content).each do |a|
          attribute a.to_sym
        end
      end
    end
  end
end
