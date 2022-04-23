# frozen_string_literal: true

require_relative 'migrations/column'
require_relative 'migrations/index'
require_relative 'migrations/options'

module RailsFormation
  module Formatters
    class Migration < Thor::Group
      include Thor::Actions

      argument :migration_configuration
      argument :migration_path

      def create_migration
        template('../templates/migration.rb.tt', migration_path)
      end

      def self.source_root
        __dir__
      end

      private

      def table_name
        migration_configuration.fetch('table')
      end

      def migration_name
        migration_configuration.fetch('migration_name')
      end

      def timestamps?
        migration_configuration.fetch('timestamps', false)
      end

      def table_options
        RailsFormation::Formatters::Migrations::Options.new(
          migration_configuration.fetch('options', [])
        ).to_s
      end

      def columns
        migration_configuration.fetch('columns', []).map do |config|
          RailsFormation::Formatters::Migrations::Column.new(config).to_s
        end
      end

      def indices
        migration_configuration.fetch('indices', []).map do |config|
          RailsFormation::Formatters::Migrations::Index.new(table_name, config).to_s
        end
      end
    end
  end
end
