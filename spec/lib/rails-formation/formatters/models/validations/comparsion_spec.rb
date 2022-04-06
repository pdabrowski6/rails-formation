require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Models::Validations::Comparsion do
  subject { described_class.new(config) }

  describe '#to_s' do
    context 'when greater_than option is passed' do
      context 'and value is specified' do
        let(:config) do
          {
            'name' => 'comparsion',
            'column' => 'age',
            'message' => '',
            'on_update' => true,
            'on_create' => true,
            'allow_nil' => false,
            'allow_blank' => false,
            'options' => {
              'comparsion_operator' => 'greater_than',
              'comparsion_value_type' => 'value',
              'comparsion_value' => '5'
            }
          }
        end

        it 'returns validation definition' do
          expect(subject.to_s).to eq('validates :age, comparsion: { greater_than: 5 }')
        end
      end

      context 'and column value is specified' do
        let(:config) do
          {
            'name' => 'comparsion',
            'column' => 'age',
            'message' => '',
            'on_update' => true,
            'on_create' => true,
            'allow_nil' => false,
            'allow_blank' => false,
            'options' => {
              'comparsion_operator' => 'greater_than',
              'comparsion_value_type' => 'column_value',
              'comparsion_value' => 'other_age'
            }
          }
        end

        it 'returns validation definition' do
          expect(subject.to_s).to eq('validates :age, comparsion: { greater_than: :other_age }')
        end
      end
    end
  end
end
