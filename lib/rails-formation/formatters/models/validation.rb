module RailsFormation
  module Formatters
    module Models
      class Validation
        def initialize(config)
          @config = config
        end

        def any?
          validations.size.positive?
        end

        def to_s
          return if validations.size.zero?

          base_definition = "validates :#{@config.fetch('name')}"
          options = validations.map { |option| option.values.join(': ') }.join(", ")
          [base_definition, ", ", options].join
        end

        private

        def validations
          @config.fetch('validations', [])
        end
      end
    end
  end
end
