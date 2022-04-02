require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Seeds::Row do
  subject { described_class.new(config) }

  let(:config) do
    {
      'factory_name' => 'user',
      'count' => 3
    }
  end

  describe '#to_s' do
    it 'returns seed definition' do
      expect(subject.to_s).to eq('3.times { FactoryBot.create(:user) }')
    end
  end
end
