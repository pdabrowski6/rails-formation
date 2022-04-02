require 'thor'
require 'rails-formation/formatters/migration'
require 'rails-formation/formatters/rubygem'
require 'rails-formation/formatters/model'
require 'rails-formation/formatters/factory'
require 'rails-formation/formatters/seed'
require 'rails-formation/cli/file_adapter'
require 'rails-formation/cli/api_adapter'
require 'rails-formation/cli/processor'

module RailsFormation
  class << self
    def apply(template)
      # bundle_and_install_gems(template.fetch('rubygems', []))
      create_and_run_migrations(template.fetch('migrations', []))
      create_factories(template.fetch('factories', []))
      # create_and_build_models(template.fetch('models', []))
      insert_seeds(template.fetch('seeds', []))
    end

    private

      def bundle_and_install_gems(rubygems)
        rubygems.each do |config|
          ::RailsFormation::Formatters::Rubygem.new([config]).invoke_all
        end
  
        system 'bundle install'
  
        rubygems.each do |config|
          config.fetch('install_commands', []).map { |command| system(command) }
        end
      end

      def create_and_run_migrations(migrations)
        migrations.each do |config|
          table_name = config.fetch('table')
          migration_name = "#{Time.now.strftime("%Y%m%d%H%M%S")}_create_#{table_name}.rb"
          migration_path = File.join(Dir.pwd, 'db', 'migrate', migration_name)
          ::RailsFormation::Formatters::Migration.new([config, migration_path]).invoke_all
          sleep(1)
        end

        system('./bin/rails db:create')
        system('./bin/rails db:migrate')
      end

      def create_factories(factories)
        factories.each do |config|
          factory_name = "#{config.fetch('name')}.rb"
          factory_path = File.join(Dir.pwd, 'spec', 'factories', factory_name)
          ::RailsFormation::Formatters::Factory.new([config, factory_path]).invoke_all
        end
      end

      def create_and_build_models(models)
        models.each do |config|
          ::RailsFormation::Formatters::Model.new([config]).invoke_all
        end
      end

      def insert_seeds(seeds)
        return if seeds.size.zero?

        seeds_path = File.join(Dir.pwd, 'db', 'seeds.rb')

        ::RailsFormation::Formatters::Seed.new([seeds, seeds_path]).invoke_all
      end
  end
end
