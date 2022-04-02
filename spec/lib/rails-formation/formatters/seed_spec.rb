require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Seed do
  subject { described_class.new([config, seeds_path]) }

  describe '#update_seeds' do
    let(:seeds_path) { File.join(Dir.pwd, 'spec', 'temp', 'base_seeds.rb') }
    let(:expectation_path) { File.join(Dir.pwd, 'spec', 'templates', 'base_seeds.rb') }
    let(:config) do
      [
        {
          'factory_name' => 'user',
          'count' => 3
        },
        {
          'factory_name' => 'article',
          'count' => 5
        }
      ]
    end

    after do
      File.delete(seeds_path) if File.exist?(seeds_path)
    end

    it 'creates seeds file' do
      subject.update_seeds

      expect(File.read(seeds_path)).to eq(File.read(expectation_path))
    end
  end
end
