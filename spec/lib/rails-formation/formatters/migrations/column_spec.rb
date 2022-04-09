# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Migrations::Column do
  subject { described_class.new(config) }

  describe '#to_s' do
    context 'when options are passed' do
      let(:config) do
        {
          'type' => 'string',
          'name' => 'first_name',
          'options' => [
            { 'name' => 'default', 'value' => 'test' },
            { 'name' => 'null', 'value' => false }
          ]
        }
      end

      it 'returns column definition' do
        expect(subject.to_s).to eq("t.string :first_name, default: 'test', null: false")
      end
    end

    context 'when options are not passed' do
      let(:config) do
        {
          'type' => 'string',
          'name' => 'first_name'
        }
      end

      it 'returns column definition' do
        expect(subject.to_s).to eq('t.string :first_name')
      end
    end
  end
end
