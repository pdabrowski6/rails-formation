# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Models::Validations::Inclusion do
  subject { described_class.new(config) }

  describe '#to_s' do
    context 'when special options are passed' do
      let(:config) do
        {
          'name' => 'inclusion',
          'column' => 'first_name',
          'message' => 'custom message',
          'on_update' => false,
          'on_create' => true,
          'allow_nil' => true,
          'allow_blank' => false,
          'options' => {
            'in' => '[1, 2, 3]'
          }
        }
      end

      it 'returns validation definition' do
        expect(
          subject.to_s
        ).to eq(
          'validates :first_name, inclusion: { allow_nil: true, message: \'custom message\', on: :create, in: [1, 2, 3] }'
        )
      end
    end

    context 'when no special options are passed' do
      let(:config) do
        {
          'name' => 'inclusion',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'in' => '[1, 2, 3]'
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, inclusion: { in: [1, 2, 3] }')
      end
    end
  end
end
