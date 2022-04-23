# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Migration do
  subject { described_class.new([config, migration_path]) }

  describe '#create_migration' do
    let(:migration_path) { File.join(Dir.pwd, 'spec', 'temp', 'base_migration.rb') }
    let(:expectation_path) { File.join(Dir.pwd, 'spec', 'templates', 'base_migration.rb') }
    let(:config) do
      {
        'table' => 'users',
        'migration_name' => 'Users',
        'timestamps' => true,
        'columns' => [
          {
            'type' => 'integer',
            'name' => 'age',
            'options' => []
          },
          {
            'type' => 'string',
            'name' => 'first_name',
            'options' => [
              { 'name' => 'default', 'value' => 'test' },
              { 'name' => 'null', 'value' => false }
            ]
          }
        ],
        'indices' => [
          {
            'column_names' => ['first_name'],
            'options' => [
              { 'name' => 'unique', 'value' => true }
            ]
          },
          {
            'column_names' => %w[first_name age],
            'options' => []
          }
        ]
      }
    end

    after do
      File.delete(migration_path) if File.exist?(migration_path)
    end

    it 'creates migration file' do
      subject.create_migration

      expect(File.read(migration_path)).to eq(File.read(expectation_path))
    end
  end
end
