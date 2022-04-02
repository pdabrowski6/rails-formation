require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Rubygems::Gem do
  subject { described_class.new(config, gemfile_path) }

  describe '#to_s' do
    let(:gemfile_path) { 'gemfile_path' }
    let(:config) do
      {
        'name' => 'factory_bot_rails',
        'version' => '6.2.0'
      }
    end

    it 'returns gem definition' do
      expect(subject.to_s).to eq("gem 'factory_bot_rails', '6.2.0'\n")
    end

    context 'when group is added' do
      let(:config) do
        {
          'name' => 'factory_bot_rails',
          'version' => '6.2.0',
          'groups' => ['development', 'test']
        }
      end

      context 'and group already exists' do
        it 'returns gem definition' do
          expect(File)
            .to receive(:read)
            .with(gemfile_path)
            .and_return("group :development, :test do")

          expect(subject.to_s).to eq("  gem 'factory_bot_rails', '6.2.0'\n")
        end
      end

      context 'and group does not exist yet' do
        it 'returns gem definition' do
          expect(File)
            .to receive(:read)
            .with(gemfile_path)
            .and_return("")

          expect(subject.to_s).to eq("group :development, :test do\n  gem 'factory_bot_rails', '6.2.0'\nend")
        end
      end
    end
  end
end
