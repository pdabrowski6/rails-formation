# frozen_string_literal: true

require 'fileutils'
require 'rails-formation/cli/file_adapter'
require 'rails-formation/cli/api_adapter'
require 'rails-formation/cli/processor'
require 'rails-formation/version'

module RailsFormation
  RailsNotInstalled = Class.new(StandardError)

  class << self
    def apply(template)
      verify_rails_installation
      generate_project(template)
      generate_files(template.fetch('files', []))

      template.fetch('commands', []).each do |project_command|
        system(project_command)
      end
    end

    private

    def verify_rails_installation
      return if system("gem list ^rails$ --version #{RailsFormation::RAILS_VERSION} -i")

      raise RailsNotInstalled, "Please install Rails #{RailsFormation::RAILS_VERSION} and retry"
    end

    def generate_project(template)
      system template['installation_command']

      Dir.chdir(template['app_name'])
    end

    def generate_files(files)
      files.each do |section|
        section_name = section.keys.first
        puts "\e[0;39;44m#{section_name}\e[0m"
        section[section_name].each do |config|
          puts "  -> \e[1;32;49mCreate\e[0m #{config['file_path']}"
          file_path = File.join(Dir.pwd, config['file_path'])
          FileUtils.mkdir_p(File.dirname(file_path))
          File.write(file_path, config['code'])
        end
      end
    end
  end
end
