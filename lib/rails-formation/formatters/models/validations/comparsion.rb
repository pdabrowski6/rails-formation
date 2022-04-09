# frozen_string_literal: true

module RailsFormation
  module Formatters
    module Models
      module Validations
        class Comparsion < RailsFormation::Formatters::Models::Validations::Base
          def to_s
            "validates :#{column_name}, comparsion: { #{extra_options.join(', ')} }"
          end

          private

          def extra_options
            base_options | extra_validation_options
          end

          def extra_validation_options
            value = if validation_options['comparsion_value_type'] == 'column_value'
                      ":#{validation_options['comparsion_value']}"
                    else
                      validation_options['comparsion_value']
                    end

            ["#{validation_options['comparsion_operator']}: #{value}"]
          end
        end
      end
    end
  end
end
