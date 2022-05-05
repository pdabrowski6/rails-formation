# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Controller do
  subject { described_class.new([config, controller_path]) }

  describe '#create_migration' do
    let(:controller_path) { File.join(Dir.pwd, 'spec', 'temp', 'users_controller.rb') }
    let(:expectation_path) { File.join(Dir.pwd, 'spec', 'templates', 'base_controller.rb') }
    let(:config) do
      {
        'class_name' => 'UsersController',
        'file_name' => 'users_controller.rb',
        'actions' => [
          { 'action' => 'index', 'access' => 'public' },
          { 'action' => 'show', 'access' => 'public' },
          { 'action' => 'users_params', 'access' => 'private' },
          { 'action' => 'set_user', 'access' => 'private' }
        ]
      }
    end

    after do
      File.delete(controller_path) if File.exist?(controller_path)
    end

    it 'creates controller file' do
      subject.create_controller

      expect(File.read(controller_path)).to eq(File.read(expectation_path))
    end
  end
end
