require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Models::Validations::Format do
  subject { described_class.new(config) }

  describe '#to_s' do
    context 'when with option is passed' do
      let(:config) do
        {
          'name' => 'format',
          'column' => 'first_name',
          'message' => '',
          'on_update' => true,
          'on_create' => true,
          'allow_nil' => false,
          'allow_blank' => false,
          'options' => {
            'format_matcher' => 'with',
            'format_value' => '/abc/'
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, format: { with: /abc/ }')
      end
    end

    context 'when without option is passed' do
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
            'format_matcher' => 'without',
            'format_value' => '/abc/'
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, format: { without: /abc/ }')
      end
    end
  end
end
