require_relative 'models/validation'

module RailsFormation
  module Formatters
    class Model < Thor::Group
      include Thor::Actions
      
      argument :model_configuration

      def create_model
        model_name = "#{class_name.downcase}.rb"
        model_path = File.join(Dir.pwd, 'app', 'models', model_name)

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
