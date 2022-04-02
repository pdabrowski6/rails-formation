require_relative 'validations/base'
require_relative 'validations/presence'

module RailsFormation
  module Formatters
    module Models
      class Validation
        MAPPINGS = {
          'presence' => ::RailsFormation::Formatters::Models::Validations::Presence
        }

        def initialize(config)
          @config = config
        end

        def to_s
          klass = MAPPINGS[@config.fetch('name')]
          klass.new(@config).to_s
        end
      end
    end
  end
end
