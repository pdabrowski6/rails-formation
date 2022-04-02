require_relative 'models/validation'

module RailsFormation
  module Formatters
    class Model < Thor::Group
      include Thor::Actions
      
      argument :model_configuration
      argument :model_path

      def create_model
        template('../templates/model.rb.tt', model_path)
      end

      def self.source_root
        __dir__
      end

      private

        def class_name
          model_configuration.fetch('name')
        end

        def validations
          model_configuration.fetch('columns', []).map { |config|
            RailsFormation::Formatters::Models::Validation.new(config)
          }.select(&:any?)
        end
    end
  end
end
