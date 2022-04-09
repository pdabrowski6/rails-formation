# frozen_string_literal: true

require 'spec_helper'
require 'pry'

RSpec.describe RailsFormation::Cli::FileAdapter do
  describe '#template' do
    it 'returns parsed JSON template' do
      template_path = File.expand_path('../../../fixtures/template.json', __dir__)

      expect(described_class.new(template_path).template).to eq({ 'title' => 'test' })
    end
  end
end
