# frozen_string_literal: true

module RailsFormation
  module Formatters
    module Migrations
      class Column
        def initialize(config)
          @config = config
        end

        def to_s
          base_definition = [
            't.',
            @config.fetch('type'),
            ' :',
            @config.fetch('name')
          ].join

          return base_definition if @config['options'].nil? || @config['options'].size.zero?

          options = @config['options'].map do |option|
            value = option['value']
            parsed_value = value.is_a?(String) ? "'#{value}'" : value

            "#{option['name']}: #{parsed_value}"
          end.join(', ')

          [base_definition, ', ', options].join
        end
      end
    end
  end
end
