# frozen_string_literal: true

module RailsFormation
  module Formatters
    module Models
      module Validations
        class Confirmation < RailsFormation::Formatters::Models::Validations::Base
          def to_s
            if base_options.any?
              "validates :#{column_name}, confirmation: { #{base_options.join(', ')} }"
            else
              "validates :#{column_name}, confirmation: true"
            end
          end
        end
      end
    end
  end
end
