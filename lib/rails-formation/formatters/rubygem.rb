require_relative 'rubygems/gem'

module RailsFormation
  module Formatters
    class Rubygem < Thor::Group
      include Thor::Actions
      
      argument :gem
      argument :gemfile_path

      def apply_to_gemfile
        gem_definition = ::RailsFormation::Formatters::Rubygems::Gem.new(gem, gemfile_path)

        insert_into_file gemfile_path, gem_definition.to_s, gem_definition.options
      end

      def self.source_root
        __dir__
      end
    end
  end
end
