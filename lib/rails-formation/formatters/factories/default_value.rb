module RailsFormation
  module Formatters
    module Factories
      class DefaultValue
        MAPPINGS = {
          'string' => 'FFaker::Lorem.sentence',
          'text' => 'FFaker::Lorem.sentence(50)',
          'boolean' => 'FFaker::Boolean.maybe',
          'time' => 'Time.zone.now',
          'date' => 'FFaker::Time.date',
          'float' => 'FFaker::Number.decimal',
          'decimal' => 'FFaker::Number.decimal',
          'integer' => 'FFaker::Number.number',
          'binary' => '',
          'timestamp' => 'Time.now.getutc',
          'datetime' => 'DateTime.now'
        }

        def self.detect(sql_type)
          MAPPINGS[sql_type]
        end
      end
    end
  end
end
