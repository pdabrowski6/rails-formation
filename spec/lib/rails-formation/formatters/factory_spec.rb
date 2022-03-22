require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Factory do
  subject { described_class.new([config, factory_path]) }

  describe '#create_migration' do
    let(:factory_path) { File.join(Dir.pwd, 'spec', 'temp', 'user.rb') }
    let(:expectation_path) { File.join(Dir.pwd, 'spec', 'templates', 'base_factory.rb') }
    let(:config) do
      {
        'name' => 'user',
        'fields' => [
          {
            'name' => 'first_name',
            'sql_type' => 'string',
            'specialized' => 'first_name'
          }
        ]
      }
    end

    after do
      File.delete(factory_path) if File.exist?(factory_path)
    end

    it 'creates factory file' do
      subject.create_factory

      expect(File.read(factory_path)).to eq(File.read(expectation_path))
    end
  end
end
