require_relative 'validations/base'
require_relative 'validations/presence'
require_relative 'validations/uniqueness'
require_relative 'validations/length'
require_relative 'validations/inclusion'
require_relative 'validations/exclusion'
require_relative 'validations/confirmation'
require_relative 'validations/format'

module RailsFormation
  module Formatters
    module Models
      class Validation
        MAPPINGS = {
          'presence' => ::RailsFormation::Formatters::Models::Validations::Presence,
          'uniqueness' => ::RailsFormation::Formatters::Models::Validations::Uniqueness,
          'length' => ::RailsFormation::Formatters::Models::Validations::Length,
          'inclusion' => ::RailsFormation::Formatters::Models::Validations::Inclusion,
          'exclusion' => ::RailsFormation::Formatters::Models::Validations::Exclusion,
          'confirmation' => ::RailsFormation::Formatters::Models::Validations::Confirmation,
          'format' => ::RailsFormation::Formatters::Models::Validations::Format
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
