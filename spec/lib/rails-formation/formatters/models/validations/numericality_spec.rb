# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Models::Validations::Numericality do
  subject { described_class.new(config) }

  describe '#to_s' do
    context 'when only_integer option is passed' do
      let(:config) do
        {
          'name' => 'numericality',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'numericality_operator' => 'only_integer',
            'numericality_value' => 3
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, numericality: { only_integer: true }')
      end
    end

    context 'when greater_than option is passed' do
      let(:config) do
        {
          'name' => 'numericality',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'numericality_operator' => 'greater_than',
            'numericality_value' => 3
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, numericality: { greater_than: 3 }')
      end
    end

    context 'when greater_than_or_equal_to option is passed' do
      let(:config) do
        {
          'name' => 'numericality',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'numericality_operator' => 'greater_than_or_equal_to',
            'numericality_value' => 3
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, numericality: { greater_than_or_equal_to: 3 }')
      end
    end

    context 'when equal_to option is passed' do
      let(:config) do
        {
          'name' => 'numericality',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'numericality_operator' => 'equal_to',
            'numericality_value' => 3
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, numericality: { equal_to: 3 }')
      end
    end

    context 'when less_than option is passed' do
      let(:config) do
        {
          'name' => 'numericality',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'numericality_operator' => 'less_than',
            'numericality_value' => 3
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, numericality: { less_than: 3 }')
      end
    end

    context 'when less_than_or_equal_to option is passed' do
      let(:config) do
        {
          'name' => 'numericality',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'numericality_operator' => 'less_than_or_equal_to',
            'numericality_value' => 3
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, numericality: { less_than_or_equal_to: 3 }')
      end
    end

    context 'when other_than option is passed' do
      let(:config) do
        {
          'name' => 'numericality',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'numericality_operator' => 'other_than',
            'numericality_value' => 3
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, numericality: { other_than: 3 }')
      end
    end

    context 'when in option is passed' do
      let(:config) do
        {
          'name' => 'numericality',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'numericality_operator' => 'in',
            'numericality_value' => '3..6'
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, numericality: { in: 3..6 }')
      end
    end

    context 'when even option is passed' do
      let(:config) do
        {
          'name' => 'numericality',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'numericality_operator' => 'even',
            'numericality_value' => 3
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, numericality: { even: true }')
      end
    end

    context 'when odd option is passed' do
      let(:config) do
        {
          'name' => 'numericality',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'numericality_operator' => 'odd',
            'numericality_value' => 3
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, numericality: { odd: true }')
      end
    end
  end
end
