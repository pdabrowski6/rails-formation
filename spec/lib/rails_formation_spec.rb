# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation do
  describe '.apply' do
    before do
      allow_any_instance_of(Kernel)
        .to receive(:system)
        .with('gem list ^rails$ --version 7.0.2.3 -i')
        .and_return(true)
      allow_any_instance_of(Kernel)
        .to receive(:system)
        .with('rails _7.0.2.3_ new sampleapp -d=postgresql')
      allow(Dir)
        .to receive(:chdir)
        .with('sampleapp')
    end

    context 'models' do
      let(:config) do
        {
          'name' => 'sampleapp',
          'models' => [
            {
              'name' => 'User',
              'columns' => [
                { 'name' => 'email', 'type' => 'string', 'validations' => [] }
              ]
            }
          ]
        }
      end

      it 'creates model' do
        model_path = File.join(Dir.pwd, 'app', 'models', 'user.rb')
        model = instance_double(RailsFormation::Formatters::Model, invoke_all: double)

        expect(RailsFormation::Formatters::Model)
          .to receive(:new)
          .with([config['models'].first, model_path])
          .and_return(model)
        expect(model)
          .to receive(:invoke_all)
          .once

        described_class.apply(config)
      end
    end

    context 'rubygems' do
      let(:config) do
        {
          'name' => 'sampleapp',
          'rubygems' => [
            { 'name' => 'factory_bot_rails', 'version' => '6.2.0', 'install_commands' => ['command1'] }
          ]
        }
      end

      it 'updates Gemfile' do
        gemfile_path = File.join(Dir.pwd, 'Gemfile')
        rubygem = instance_double(RailsFormation::Formatters::Rubygem, invoke_all: double)

        expect(RailsFormation::Formatters::Rubygem)
          .to receive(:new)
          .with([config['rubygems'].first, gemfile_path])
          .and_return(rubygem)
        expect(rubygem)
          .to receive(:invoke_all)
          .once
        expect_any_instance_of(Kernel)
          .to receive(:system)
          .with('bundle install')
          .once
        expect_any_instance_of(Kernel)
          .to receive(:system)
          .with('command1')
          .once

        described_class.apply(config)
      end
    end

    context 'seeds' do
      let(:config) do
        {
          'name' => 'sampleapp',
          'seeds' => [
            { 'factory_name' => 'user', 'count' => 2 }
          ]
        }
      end

      it 'updates seeds' do
        seeds_path = File.join(Dir.pwd, 'db', 'seeds.rb')
        seeds = instance_double(RailsFormation::Formatters::Seed, invoke_all: double)

        expect(RailsFormation::Formatters::Seed)
          .to receive(:new)
          .with([config['seeds'], seeds_path])
          .and_return(seeds)
        expect(seeds)
          .to receive(:invoke_all)
          .once
        expect_any_instance_of(Kernel)
          .to receive(:system)
          .with('./bin/rails db:seed')

        described_class.apply(config)
      end
    end

    context 'factories' do
      let(:config) do
        {
          'name' => 'sampleapp',
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
          'name' => 'sampleapp',
          'migrations' => [
            { 'table' => 'users', 'columns' => [] }
          ]
        }
      end

      it 'applies migrations' do
        current_time = Time.now

        Timecop.freeze(current_time) do
          migration_name = "#{Time.now.strftime('%Y%m%d%H%M%S')}_create_users.rb"
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
