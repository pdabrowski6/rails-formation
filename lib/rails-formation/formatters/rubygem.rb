module RailsFormation
  module Formatters
    class Rubygem < Thor::Group
      include Thor::Actions
      
      argument :gem

      def apply_to_gemfile
        gem_line = "  gem '#{gem['name']}', '#{gem['version']}'\n"
        gemfile_path = File.join(Dir.pwd, 'Gemfile')

        if insert_after
          insert_into_file gemfile_path, gem_line, after: insert_after
        else
          insert_into_file gemfile_path, gem_line
        end 
      end

      def self.source_root
        __dir__
      end

      private

        def insert_after
          return if gem.fetch('groups', []).size.zero?

          groups_def = gem['groups'].map { |name| ":#{name}" }.join(", ")

          "group #{groups_def} do\n"
        end
    end
  end
end
