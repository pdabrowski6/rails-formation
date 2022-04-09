# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Factories::Value do
  describe '.detect' do
    it 'returns ffaker gem mapping for the given value type' do
      expect(described_class.detect('first_name')).to eq('FFaker::Name.first_name')
    end
  end
end
