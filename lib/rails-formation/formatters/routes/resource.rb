# frozen_string_literal: true

module RailsFormation
  module Formatters
    module Routes
      class Resource
        def initialize(config)
          @config = config
        end

        def start_line
          if actions_line.nil?
            "resources :#{resource_name}"
          else
            "resources :#{resource_name}, #{actions_line}"
          end
        end

        def additional_routes
          mappings = {}

          mappings['member'] = member_routes.map(&method(:build_route)) if member_routes.size.positive?

          mappings['collection'] = collection_routes.map(&method(:build_route)) if collection_routes.size.positive?

          mappings
        end

        def create_block?
          member_routes.size.positive? || collection_routes.size.positive?
        end

        private

        def build_route(route)
          "#{route['request']} :#{route['action']}"
        end

        def actions_line
          return if actions.size == default_actions.size

          if actions.size > 3
            except_actions = (default_actions - actions).map { |action| ":#{action}" }
            "except: [#{except_actions.join(', ')}]"
          else
            only_actions = actions.map { |action| ":#{action}" }
            "only: [#{only_actions.join(', ')}]"
          end
        end

        def resource_name
          @config.fetch('resource')
        end

        def actions
          @config.fetch('restful_actions')
        end

        def default_actions
          %w[index show new create edit update destroy]
        end

        def member_routes
          @config.fetch('additional_routes').fetch('member', [])
        end

        def collection_routes
          @config.fetch('additional_routes').fetch('collection', [])
        end
      end
    end
  end
end
