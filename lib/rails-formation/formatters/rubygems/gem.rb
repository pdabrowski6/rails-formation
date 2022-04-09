# frozen_string_literal: true

module RailsFormation
  module Formatters
    module Rubygems
      class Gem
        def initialize(config, gemfile_path)
          @config = config
          @gemfile_path = gemfile_path
        end

        def to_s
          if create_group?
            "#{groups_def}  #{base_definition}end"
          elsif insert_after?
            "  #{base_definition}"
          else
            base_definition
          end
        end

        def insert_after?
          !groups_def.nil?
        end

        def options
          if !create_group? && insert_after?
            { after: groups_def }
          else
            {}
          end
        end

        private

        def base_definition
          "gem '#{@config['name']}', '#{@config['version']}'\n"
        end

        def create_group?
          return false if groups_def.nil?

          !File.read(@gemfile_path).include?(groups_def.gsub("\n", ''))
        end

        def groups_def
          return if @config.fetch('groups', []).size.zero?

          groups_def = @config['groups'].map { |name| ":#{name}" }.join(', ')

          "group #{groups_def} do\n"
        end
      end
    end
  end
end
