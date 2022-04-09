# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Model do
  subject { described_class.new([config, model_path]) }

  describe '#create_migration' do
    let(:model_path) { File.join(Dir.pwd, 'spec', 'temp', 'user.rb') }
    let(:expectation_path) { File.join(Dir.pwd, 'spec', 'templates', 'base_model.rb') }
    let(:config) do
      {
        'name' => 'User',
        'columns' => []
      }
    end

    after do
      File.delete(model_path) if File.exist?(model_path)
    end

    it 'creates model file' do
      subject.create_model

      expect(File.read(model_path)).to eq(File.read(expectation_path))
    end
  end
end
