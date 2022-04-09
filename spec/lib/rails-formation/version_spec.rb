# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::VERSION do
  it 'returns version number' do
    expect(RailsFormation::VERSION).to eq('0.0.0.1')
  end
end

RSpec.describe RailsFormation::RAILS_VERSION do
  it 'returns version number' do
    expect(RailsFormation::RAILS_VERSION).to eq('7.0.2.3')
  end
end
