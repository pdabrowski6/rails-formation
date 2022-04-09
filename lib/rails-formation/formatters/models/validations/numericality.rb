# frozen_string_literal: true

module RailsFormation
  module Formatters
    module Models
      module Validations
        class Numericality < RailsFormation::Formatters::Models::Validations::Base
          def to_s
            "validates :#{column_name}, numericality: { #{extra_options.join(', ')} }"
          end

          private

          def extra_options
            base_options | extra_validation_options
          end

          def extra_validation_options
            options = []

            if validation_options['numericality_operator'] == 'greater_than'
              options << "greater_than: #{validation_options['numericality_value']}"
            end

            options << 'only_integer: true' if validation_options['numericality_operator'] == 'only_integer'

            if validation_options['numericality_operator'] == 'greater_than_or_equal_to'
              options << "greater_than_or_equal_to: #{validation_options['numericality_value']}"
            end

            if validation_options['numericality_operator'] == 'equal_to'
              options << "equal_to: #{validation_options['numericality_value']}"
            end

            if validation_options['numericality_operator'] == 'less_than'
              options << "less_than: #{validation_options['numericality_value']}"
            end

            if validation_options['numericality_operator'] == 'less_than_or_equal_to'
              options << "less_than_or_equal_to: #{validation_options['numericality_value']}"
            end

            if validation_options['numericality_operator'] == 'other_than'
              options << "other_than: #{validation_options['numericality_value']}"
            end

            options << "in: #{validation_options['numericality_value']}" if validation_options['numericality_operator'] == 'in'

            options << 'odd: true' if validation_options['numericality_operator'] == 'odd'

            options << 'even: true' if validation_options['numericality_operator'] == 'even'

            options
          end
        end
      end
    end
  end
end
