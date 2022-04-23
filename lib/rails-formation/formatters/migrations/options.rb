# frozen_string_literal: true

module RailsFormation
  module Formatters
    module Migrations
      class Options
        def initialize(options)
          @options = options
        end

        def to_s
          return if @options.size.zero?

          @options.map { |option| option.values.join(': ') }.join(', ')
        end
      end
    end
  end
end
