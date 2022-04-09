# frozen_string_literal: true

module RailsFormation
  module Formatters
    module Models
      module Validations
        class Uniqueness < RailsFormation::Formatters::Models::Validations::Base
          def to_s
            if extra_options.any?
              "validates :#{column_name}, uniqueness: { #{extra_options.join(', ')} }"
            else
              "validates :#{column_name}, uniqueness: true"
            end
          end

          private

          def extra_options
            base_options | extra_validation_options
          end

          def extra_validation_options
            options = []

            options << 'case_sensitive: false' unless case_sensitive?

            options << scope unless blank_scope?

            options
          end

          def case_sensitive?
            validation_options['uniqueness_case_sensitive'].to_i == 1
          end

          def blank_scope?
            validation_options['uniqueness_scope'].nil? ||
              validation_options['uniqueness_scope'].reject(&:empty?).size.zero?
          end

          def scope
            return [] if validation_options['uniqueness_scope'].nil?

            sanitized_scope = validation_options['uniqueness_scope'].reject(&:empty?)

            return [] if sanitized_scope.size.zero?

            if sanitized_scope.size == 1
              "scope: :#{sanitized_scope.first}"
            else
              "scope: [#{sanitized_scope.map { |s| ":#{s}" }.join(', ')}]"
            end
          end
        end
      end
    end
  end
end
