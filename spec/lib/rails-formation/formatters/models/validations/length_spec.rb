# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Models::Validations::Length do
  subject { described_class.new(config) }

  describe '#to_s' do
    context 'when minimal option is passed' do
      let(:config) do
        {
          'name' => 'length',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'length_operator_type' => 'range',
            'length_value' => nil,
            'length_min_value' => '1',
            'length_max_value' => ''
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, length: { minimum: 1 }')
      end
    end

    context 'when maximum option is passed' do
      let(:config) do
        {
          'name' => 'length',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'length_operator_type' => 'range',
            'length_value' => nil,
            'length_min_value' => '',
            'length_max_value' => '10'
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, length: { maximum: 10 }')
      end
    end

    context 'when range is passed' do
      let(:config) do
        {
          'name' => 'length',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'length_operator_type' => 'range',
            'length_value' => nil,
            'length_min_value' => '1',
            'length_max_value' => '10'
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, length: { in: 1..10 }')
      end
    end

    context 'when special options are passed' do
      let(:config) do
        {
          'name' => 'length',
          'column' => 'first_name',
          'message' => 'custom message',
          'on_update' => false,
          'on_create' => true,
          'allow_nil' => true,
          'allow_blank' => false,
          'options' => {
            'length_operator_type' => 'value',
            'length_value' => '3'
          }
        }
      end

      it 'returns validation definition' do
        expect(
          subject.to_s
        ).to eq(
          'validates :first_name, length: { allow_nil: true, message: \'custom message\', on: :create, is: 3 }'
        )
      end
    end

    context 'when no special options are passed' do
      let(:config) do
        {
          'name' => 'length',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'length_operator_type' => 'value',
            'length_value' => '3'
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, length: { is: 3 }')
      end
    end
  end
end
