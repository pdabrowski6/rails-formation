# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Migrations::Options do
  subject { described_class.new(options) }

  let(:options) do
    [{ 'name' => 'id', 'value' => false }]
  end

  describe '#to_s' do
    it 'returns options string' do
      expect(subject.to_s).to eq('id: false')
    end
  end
end
