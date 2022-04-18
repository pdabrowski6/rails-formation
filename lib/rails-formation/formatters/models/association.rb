# frozen_string_literal: true

module RailsFormation
  module Formatters
    module Models
      class Association
        def initialize(config)
          @config = config
        end

        def to_s
          base_def = "#{relation} :#{destination}"

          return base_def if options.size.zero?

          options_def = options.map { |option| option.values.join(': ') }.join(', ')

          "#{base_def}, #{options_def}"
        end

        private

        def relation
          @config.fetch('type')
        end

        def destination
          @config.fetch('destination')
        end

        def options
          @config.fetch('options', [])
        end
      end
    end
  end
end
