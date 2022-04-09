# frozen_string_literal: true

require_relative 'factories/column'

module RailsFormation
  module Formatters
    class Factory < Thor::Group
      include Thor::Actions

      argument :factory_configuration
      argument :factory_path

      def create_factory
        template('../templates/factory.rb.tt', factory_path)
      end

      def self.source_root
        __dir__
      end

      private

      def factory_name
        factory_configuration.fetch('name')
      end

      def associations
        []
      end

      def columns
        factory_configuration.fetch('fields', []).map do |config|
          RailsFormation::Formatters::Factories::Column.new(config).to_s
        end
      end
    end
  end
end
