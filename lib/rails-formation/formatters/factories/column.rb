# frozen_string_literal: true

require_relative 'default_value'
require_relative 'value'

module RailsFormation
  module Formatters
    module Factories
      class Column
        def initialize(config)
          @config = config
        end

        def to_s
          if @config.key?('has_confirmation')
            base_part = "#{name} { #{value} }"
            "#{base_part}\n  #{name}_confirmation { #{name} }"
          else
            "#{name} { #{value} }"
          end
        end

        private

        def name
          @config.fetch('name')
        end

        def sql_type
          @config.fetch('sql_type')
        end

        def specialized
          @config.fetch('specialized')
        end

        def use_sql_type?
          specialized == 'default'
        end

        def default_value
          ::RailsFormation::Formatters::Factories::DefaultValue
        end

        def value
          if @config.key?('in')
            "#{@config.fetch('in')}.sample"
          else
            raw_value
          end
        end

        def raw_value
          if use_sql_type?
            ::RailsFormation::Formatters::Factories::DefaultValue.detect(sql_type)
          else
            ::RailsFormation::Formatters::Factories::Value.detect(specialized)
          end
        end
      end
    end
  end
end
