require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Models::Validations::Uniqueness do
  subject { described_class.new(config) }

  describe '#to_s' do
    context 'when special options are passed' do
      context 'and match is not sensitive' do
        let(:config) do
          {
            'name' => 'presence',
            'column' => 'first_name',
            'message' => '',
            'on_update' => true,
            'on_create' => true,
            'allow_nil' => false,
            'allow_blank' => false,
            'options' => {
              'uniqueness_case_sensitive' => '0'
            }
          }
        end
  
        it 'returns validation definition' do
          expect(subject.to_s).to eq('validates :first_name, uniqueness: { case_sensitive: false }')
        end
      end

      context 'and scope is with one column' do
        let(:config) do
          {
            'name' => 'presence',
            'column' => 'first_name',
            'message' => '',
            'on_update' => true,
            'on_create' => true,
            'allow_nil' => false,
            'allow_blank' => false,
            'options' => {
              'uniqueness_case_sensitive' => '1',
              'uniqueness_scope' => ['', 'last_name']
            }
          }
        end
  
        it 'returns validation definition' do
          expect(subject.to_s).to eq('validates :first_name, uniqueness: { scope: :last_name }')
        end
      end

      context 'and scope is with multiple columns' do
        let(:config) do
          {
            'name' => 'presence',
            'column' => 'first_name',
            'message' => '',
            'on_update' => true,
            'on_create' => true,
            'allow_nil' => false,
            'allow_blank' => false,
            'options' => {
              'uniqueness_case_sensitive' => '1',
              'uniqueness_scope' => ['', 'last_name', 'email']
            }
          }
        end
  
        it 'returns validation definition' do
          expect(subject.to_s).to eq('validates :first_name, uniqueness: { scope: [:last_name, :email] }')
        end
      end
    end

    context 'when base special options are passed' do
      let(:config) do
        {
          'name' => 'presence',
          'column' => 'first_name',
          'message' => 'custom message',
          'on_update' => false,
          'on_create' => true,
          'allow_nil' => true,
          'allow_blank' => false,
          'options' => {
            'uniqueness_case_sensitive' => '1'
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, uniqueness: { allow_nil: true, message: \'custom message\', on: :create }')
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
          'allow_blank' => false,
          'options' => {
            'uniqueness_case_sensitive' => '1'
          }
        }
      end

      it 'returns validation definition' do
        expect(subject.to_s).to eq('validates :first_name, uniqueness: true')
      end
    end
  end
end
