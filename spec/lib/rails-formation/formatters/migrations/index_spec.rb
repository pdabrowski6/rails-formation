require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Migrations::Index do
  subject { described_class.new('users', config) }

  describe '#to_s' do
    context 'when options are given' do
      let(:config) do
        {
          'column_names' => ['first_name'],
          'options' => [
            { 'name' => 'unique', 'value' => true }
          ]
        }
      end

      it 'returns index definition' do
        expect(subject.to_s).to eq('add_index :users, :first_name, unique: true')
      end
    end

    context 'when one column is given for index' do
      let(:config) do
        {
          'column_names' => ['first_name']
        }
      end

      it 'returns index definition' do
        expect(subject.to_s).to eq('add_index :users, :first_name')
      end
    end

    context 'when multiple columns are given for index' do
      let(:config) do
        {
          'column_names' => ['first_name', 'last_name']
        }
      end

      it 'returns index definition' do
        expect(subject.to_s).to eq('add_index :users, [:first_name, :last_name]')
      end
    end
  end
end
