require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Factories::Column do
  subject { described_class.new(config) }

  describe '#to_s' do
    context 'validations' do
      context 'when confirmation validation is applied' do
        let(:config) do
          {
            'name' => 'first_name',
            'sql_type' => 'string',
            'specialized' => 'default',
            'has_confirmation' => true
          }
        end
  
        it 'returns factory definition' do
          expect(subject.to_s).to eq("first_name { FFaker::Lorem.sentence }\nfirst_name_confirmation { first_name }")
        end
      end

      context 'when inclusion validation is applied' do
        let(:config) do
          {
            'name' => 'first_name',
            'sql_type' => 'string',
            'specialized' => 'default',
            'in' => "['abc', 'efg']"
          }
        end
  
        it 'returns factory definition' do
          expect(subject.to_s).to eq("first_name { ['abc', 'efg'].sample }")
        end
      end
    end

    context 'when data type is general' do
      let(:config) do
        {
          'name' => 'first_name',
          'sql_type' => 'string',
          'specialized' => 'default'
        }
      end

      it 'returns factory definition' do
        expect(subject.to_s).to eq('first_name { FFaker::Lorem.sentence }')
      end
    end

    context 'when data type is specialized' do
      let(:config) do
        {
          'name' => 'first_name',
          'sql_type' => 'string',
          'specialized' => 'first_name'
        }
      end

      it 'returns factory definition' do
        expect(subject.to_s).to eq('first_name { FFaker::Name.first_name }')
      end
    end
  end
end
