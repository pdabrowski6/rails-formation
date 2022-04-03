module RailsFormation
  module Formatters
    module Models
      module Validations
        class Format < RailsFormation::Formatters::Models::Validations::Base
          def to_s
            "validates :#{column_name}, format: { #{extra_options.join(', ')} }"
          end

          private

          def extra_options
            base_options | extra_validation_options
          end

          def extra_validation_options
            options = []

            if validation_options['format_matcher'] == 'with'
              options << "with: #{validation_options['format_value']}"
            end

            if validation_options['format_matcher'] == 'without'
              options << "without: #{validation_options['format_value']}"
            end

            options
          end
        end
      end
    end
  end
end
