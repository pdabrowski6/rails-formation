require 'spec_helper'

RSpec.describe RailsFormation::Cli::Processor do
  subject { described_class.new(args) }

  describe '#call' do
    context 'when command is not supported' do
      let(:args) { ['invalid', 'template.json'] }

      it 'raises InvalidCommand error' do
        expect { subject.call }.to raise_error(RailsFormation::Cli::Processor::InvalidCommand)
      end
    end

    context 'when adapter is not matched' do
      let(:args) { ['apply', 'invalid'] }

      it 'raises InvalidUid error' do
        expect { subject.call }.to raise_error(RailsFormation::Cli::Processor::InvalidUid)
      end
    end

    context 'when template path is matched' do
      let(:args) { ['apply', 'template.json'] }

      it 'returns file adapter' do
        adapter = instance_double(RailsFormation::Cli::FileAdapter, template: 'template')

        expect(RailsFormation::Cli::FileAdapter)
          .to receive(:new)
          .with('template.json')
          .and_return(adapter)
        expect(RailsFormation)
          .to receive(:apply)
          .with(adapter.template)
          .once

        subject.call
      end
    end

    context 'when token is matched' do
      let(:args) { ['apply', 'rft-123'] }

      it 'returns api adapter' do
        adapter = instance_double(RailsFormation::Cli::ApiAdapter, template: 'template')

        expect(RailsFormation::Cli::ApiAdapter)
          .to receive(:new)
          .with('rft-123')
          .and_return(adapter)
        expect(RailsFormation)
          .to receive(:apply)
          .with(adapter.template)
          .once

        subject.call
      end
    end
  end
end
