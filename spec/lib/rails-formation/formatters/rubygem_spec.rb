# frozen_string_literal: true

require 'spec_helper'
require 'fileutils'

RSpec.describe RailsFormation::Formatters::Rubygem do
  subject { described_class.new([config, gemfile_path]) }

  describe '#create_migration' do
    let(:gemfile_path) { File.join(Dir.pwd, 'spec', 'temp', 'Gemfile') }
    let(:expectation_path) { File.join(Dir.pwd, 'spec', 'templates', 'Gemfile') }
    let(:config) do
      {
        'install_commands' => [],
        'name' => 'factory_bot_rails',
        'version' => '6.2.0',
        'groups' => []
      }
    end

    after do
      File.delete(gemfile_path) if File.exist?(gemfile_path)
    end

    before do
      FileUtils.touch(gemfile_path)
    end

    it 'updates Gemfile' do
      subject.apply_to_gemfile

      expect(File.read(gemfile_path)).to eq(File.read(expectation_path))
    end
  end
end
