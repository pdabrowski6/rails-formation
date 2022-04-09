# frozen_string_literal: true

module RailsFormation
  module Cli
    class Processor
      COMMANDS = %w[apply].freeze

      InvalidCommand = Class.new(StandardError)
      InvalidUid = Class.new(StandardError)

      def initialize(args)
        @command = args[0]
        @uid = args[1]
      end

      def call
        validate_command

        ::RailsFormation.apply(adapter.template)
      end

      private

      def validate_command
        raise InvalidCommand, "command #{@command} is not supported!" unless COMMANDS.include?(@command.to_s.downcase)
      end

      def adapter
        case @uid
        when /.*.json$/
          ::RailsFormation::Cli::FileAdapter.new(@uid)
        when /^rft-.*/
          ::RailsFormation::Cli::ApiAdapter.new(@uid)
        else
          raise InvalidUid, "#{@uid} is not valid template file or UID"
        end
      end
    end
  end
end
