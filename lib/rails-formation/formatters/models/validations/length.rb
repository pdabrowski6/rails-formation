# frozen_string_literal: true

module RailsFormation
  module Formatters
    module Models
      module Validations
        class Length < RailsFormation::Formatters::Models::Validations::Base
          def to_s
            "validates :#{column_name}, length: { #{extra_options.join(', ')} }"
          end

          private

          def extra_options
            base_options | extra_validation_options
          end

          def extra_validation_options
            options = []

            options << "is: #{validation_options['length_value']}" if exact_length?

            options << "minimum: #{validation_options['length_min_value']}" if min_length?

            options << "maximum: #{validation_options['length_max_value']}" if max_length?

            options << "in: #{validation_options['length_min_value']}..#{validation_options['length_max_value']}" if range_length?

            options
          end

          def exact_length?
            validation_options['length_operator_type'] == 'value' &&
              !validation_options['length_value'].nil?
          end

          def min_length?
            validation_options['length_operator_type'] == 'range' &&
              validation_options['length_max_value'].to_i.zero? &&
              validation_options['length_min_value'].to_i.positive?
          end

          def max_length?
            validation_options['length_operator_type'] == 'range' &&
              validation_options['length_min_value'].to_i.zero? &&
              validation_options['length_max_value'].to_i.positive?
          end

          def range_length?
            validation_options['length_operator_type'] == 'range' &&
              validation_options['length_min_value'].to_i.positive? &&
              validation_options['length_max_value'].to_i.positive?
          end
        end
      end
    end
  end
end
