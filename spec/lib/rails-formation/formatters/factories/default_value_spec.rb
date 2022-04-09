# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Factories::DefaultValue do
  describe '.detect' do
    it 'returns ffaker gem mapping for the given value type' do
      expect(described_class.detect('string')).to eq('FFaker::Lorem.sentence')
    end
  end
end
