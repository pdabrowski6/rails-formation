# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Route do
  subject { described_class.new([config, routes_path]) }

  describe '#create_migration' do
    let(:routes_path) { File.join(Dir.pwd, 'spec', 'temp', 'routes.rb') }
    let(:expectation_path) { File.join(Dir.pwd, 'spec', 'templates', 'base_routes.rb') }
    let(:config) do
      [
        {
          'resource' => 'articles',
          'restful_actions' => %w[index show new create edit update destroy],
          'additional_routes' => {
            'collection' => [],
            'member' => [
              { 'request' => 'get', 'action' => 'publish' }
            ]
          }
        },
        {
          'resource' => 'users',
          'restful_actions' => %w[index show new create edit update destroy],
          'additional_routes' => {}
        },
        {
          'resource' => 'companies',
          'restful_actions' => %w[index],
          'additional_routes' => {}
        }
      ]
    end

    after do
      File.delete(routes_path) if File.exist?(routes_path)
    end

    it 'creates routes file' do
      subject.insert_routes

      expect(File.read(routes_path)).to eq(File.read(expectation_path))
    end
  end
end
