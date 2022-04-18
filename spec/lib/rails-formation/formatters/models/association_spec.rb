# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Models::Association do
  subject { described_class.new(config) }

  describe '#to_s' do
    context 'when options are passed' do
      let(:config) do
        {
          'type' => 'has_one',
          'destination' => 'profile',
          'options' => [
            { 'name' => 'dependent', 'value' => ':destroy' }
          ]
        }
      end

      it 'returns association definition' do
        expect(subject.to_s).to eq('has_one :profile, dependent: :destroy')
      end
    end

    context 'when options are not passed' do
      let(:config) do
        {
          'type' => 'has_one',
          'destination' => 'profile',
          'options' => []
        }
      end

      it 'returns association definition' do
        expect(subject.to_s).to eq('has_one :profile')
      end
    end
  end
end
