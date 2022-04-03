require_relative 'validations/base'
require_relative 'validations/presence'
require_relative 'validations/uniqueness'

module RailsFormation
  module Formatters
    module Models
      class Validation
        MAPPINGS = {
          'presence' => ::RailsFormation::Formatters::Models::Validations::Presence,
          'uniqueness' => ::RailsFormation::Formatters::Models::Validations::Uniqueness
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
