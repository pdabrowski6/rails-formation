# frozen_string_literal: true

require_relative 'routes/resource'

module RailsFormation
  module Formatters
    class Route < Thor::Group
      include Thor::Actions

      argument :routes_configuration
      argument :routes_path

      def insert_routes
        template('../templates/routes.rb.tt', routes_path)
      end

      def self.source_root
        __dir__
      end

      private

      def resources
        routes_configuration.map { |config| ::RailsFormation::Formatters::Routes::Resource.new(config) }
      end
    end
  end
end
