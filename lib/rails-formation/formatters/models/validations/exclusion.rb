module RailsFormation
  module Formatters
    module Models
      module Validations
        class Exclusion < RailsFormation::Formatters::Models::Validations::Base
          def to_s
            "validates :#{column_name}, exclusion: { #{extra_options.join(', ')} }"
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
