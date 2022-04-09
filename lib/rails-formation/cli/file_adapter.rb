# frozen_string_literal: true

require 'json'

module RailsFormation
  module Cli
    class FileAdapter
      def initialize(file_path)
        @file_path = file_path
      end

      def template
        raw_json = File.read(@file_path)
        JSON.parse(raw_json)
      end
    end
  end
end
