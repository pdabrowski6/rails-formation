require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Models::Validations::Confirmation do
  subject { described_class.new(config) }

  describe '#to_s' do
    context 'when special options are passed' do
      let(:config) do
        {
          'name' => 'presence',
          'column' => 'first_name',
          'message' => 'custom message',
          'on_update' => false,
          'on_create' => true,
          'allow_nil' => true,
          'allow_blank' => false 
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, confirmation: { allow_nil: true, message: \'custom message\', on: :create }')
      end
    end

    context 'when no special options are passed' do
      let(:config) do
        {
          'name' => 'presence',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false 
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, confirmation: true')
      end
    end
  end
end
