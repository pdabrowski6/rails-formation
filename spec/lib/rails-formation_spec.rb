require 'spec_helper'

RSpec.describe RailsFormation do
  describe '.apply' do
    context 'factories' do
      let(:config) do
        {
          'factories' => [
            { 'name' => 'user', 'fields' => [] }
          ]
        }
      end

      it 'applies factories' do
        factory_path = File.join(Dir.pwd, 'spec', 'factories', 'user.rb')
        factory = instance_double(RailsFormation::Formatters::Factory, invoke_all: double)

        expect(RailsFormation::Formatters::Factory)
          .to receive(:new)
          .with([config['factories'].first, factory_path])
          .and_return(factory)
        expect(factory)
          .to receive(:invoke_all)
          .once

        described_class.apply(config)
      end
    end

    context 'migrations' do
      let(:config) do
        {
          'migrations' => [
            { 'table' => 'users', 'columns' => [] }
          ]
        }
      end

      it 'applies migrations' do
        current_time = Time.now

        Timecop.freeze(current_time) do
          migration_name = "#{Time.now.strftime("%Y%m%d%H%M%S")}_create_users.rb"
          migration_path = File.join(Dir.pwd, 'db', 'migrate', migration_name)
          migration = instance_double(RailsFormation::Formatters::Migration, invoke_all: double)

          expect(RailsFormation::Formatters::Migration)
            .to receive(:new)
            .with([config['migrations'].first, migration_path])
            .and_return(migration)
          expect(migration)
            .to receive(:invoke_all)
            .once
          expect_any_instance_of(Kernel)
            .to receive(:system)
            .with('./bin/rails db:create')
            .once
          expect_any_instance_of(Kernel)
            .to receive(:system)
            .with('./bin/rails db:migrate')
            .once

          described_class.apply(config)
        end
      end
    end
  end
end
