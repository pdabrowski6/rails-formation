module RailsFormation
  module Formatters
    module Models
      module Validations
        class Inclusion < RailsFormation::Formatters::Models::Validations::Base
          def to_s
            "validates :#{column_name}, inclusion: { #{extra_options.join(', ')} }"
          end

          private

          def extra_options
            base_options | extra_validation_options
          end

          def extra_validation_options
            ["in: #{validation_options['in']}"]
          end
        end
      end
    end
  end
end
