module RailsFormation
  module Formatters
    module Models
      module Validations
        class Base
          def initialize(config)
            @config = config
          end

          private

          def allow_blank_option
            return unless @config.fetch('allow_blank')
  
            'allow_blank: true'
          end
  
          def allow_nil_option
            return unless @config.fetch('allow_nil')
  
            'allow_nil: true'
          end
  
          def message_option
            return if @config.fetch('message').nil? || @config.fetch('message').empty?
  
            "message: '#{@config.fetch('message')}'"
          end
  
          def on_option
            return if @config.fetch('on_create') && @config.fetch('on_update')
  
            if @config.fetch('on_create')
              'on: :create'
            elsif @config.fetch('on_update')
              'on: :update'
            end
          end
  
          def column_name
            @config.fetch('column')
          end

          def base_options
            [
              allow_blank_option,
              allow_nil_option,
              message_option,
              on_option
            ].compact
          end
        end
      end
    end
  end
end
