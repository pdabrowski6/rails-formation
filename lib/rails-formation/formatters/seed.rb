require_relative 'seeds/row'

module RailsFormation
  module Formatters
    class Seed < Thor::Group
      include Thor::Actions
      
      argument :seeds_configuration
      argument :seeds_path

      def update_seeds
        template('../templates/seeds.rb.tt', seeds_path)
      end

      def self.source_root
        __dir__
      end

      private

        def seeds
          seeds_configuration.map { |config|
          RailsFormation::Formatters::Seeds::Row.new(config).to_s
          }
        end
    end
  end
end
