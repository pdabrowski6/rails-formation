require 'spec_helper'

RSpec.describe RailsFormation::VERSION do
  it 'returns version number' do
    expect(RailsFormation::VERSION).to eq('0.0.0.1')
  end
end
