module RailsFormation
  module Formatters
    module Migrations
      class Index
        def initialize(table_name, config)
          @table_name = table_name
          @config = config
        end

        def to_s
          column_slug = if @config.fetch('column_names').size == 1
            ":#{@config.fetch('column_names').first}"
          else
            "[#{@config.fetch('column_names').map { |col| ":#{col}" }.join(", ")}]"
          end

          base_definition = "add_index :#{@table_name}, #{column_slug}"

          return base_definition if @config.fetch('options', []).size.zero?

          options = @config['options'].map { |option| option.values.join(': ') }.join(", ")

          "#{base_definition}, #{options}"
        end
      end
    end
  end
end
