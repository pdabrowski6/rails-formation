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
          models_with_validations = model_configuration.fetch('columns', []).select do |config|
            config.fetch('validations', []).size.positive?
          end
          
          models_with_validations.map do |config|
            config.fetch('validations', []).map do |val_config|
              ::RailsFormation::Formatters::Models::Validation.new(
                val_config.merge('column' => config.fetch('name'))
              ).to_s
            end
          end.flatten
        end
    end
  end
end
