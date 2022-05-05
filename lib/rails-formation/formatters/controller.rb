# frozen_string_literal: true

module RailsFormation
  module Formatters
    class Controller < Thor::Group
      include Thor::Actions

      argument :controller_configuration
      argument :controller_path

      def create_controller
        template('../templates/controller.rb.tt', controller_path)
      end

      def self.source_root
        __dir__
      end

      private

      def controller_class
        controller_configuration.fetch('class_name')
      end

      def public_actions
        controller_configuration.fetch('actions').select(&method(:public_action?)).map { |action| action['action'] }
      end

      def private_actions
        controller_configuration.fetch('actions').select(&method(:private_action?)).map { |action| action['action'] }
      end

      def public_action?(action)
        action['access'] == 'public'
      end

      def private_action?(action)
        action['access'] == 'private'
      end
    end
  end
end
