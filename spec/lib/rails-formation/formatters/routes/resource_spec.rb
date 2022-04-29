# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsFormation::Formatters::Routes::Resource do
  subject { described_class.new(config) }

  describe '#additional_routes' do
    let(:config) do
      {
        'additional_routes' => {
          'member' => [ { 'action' => 'test', 'request' => 'get' }],
          'collection' => [ { 'action' => 'verify', 'request' => 'post' }]
        }
      }
    end

    it 'returns additional routes configuration' do
      expect(subject.additional_routes).to eq({
        'member' => ['get :test'],
        'collection' => ['post :verify']
      })
    end
  end

  describe '#start_line' do
    context 'when all RESTful actions are passed' do
      let(:config) do
        {
          'resource' => 'articles',
          'restful_actions' => %w[index show new create edit update destroy]
        }
      end

      it 'returns base definition' do
        expect(subject.start_line).to eq('resources :articles')
      end
    end

    context 'when less than 4 RESTful actions are passed' do
      let(:config) do
        {
          'resource' => 'articles',
          'restful_actions' => %w[index show new]
        }
      end

      it 'returns definition with only keyword' do
        expect(subject.start_line).to eq('resources :articles, only: [:index, :show, :new]')
      end
    end

    context 'when more than 3 RESTful actions are passed' do
      let(:config) do
        {
          'resource' => 'articles',
          'restful_actions' => %w[index show new create edit]
        }
      end

      it 'returns definition with except keyword' do
        expect(subject.start_line).to eq('resources :articles, except: [:update, :destroy]')
      end
    end
  end

  describe '#create_block?' do
    context 'when member routes are passed' do
      let(:config) do
        {
          'additional_routes' => {
            'member' => [ { 'action' => 'test', 'request' => 'get' }],
            'collection' => []
          }
        }
      end

      it 'returns true' do
        expect(subject.create_block?).to eq(true)
      end
    end

    context 'when member routes are not passed' do
      context 'and collection routes are passed' do
        let(:config) do
          {
            'additional_routes' => {
              'collection' => [ { 'action' => 'test', 'request' => 'get' }],
              'member' => []
            }
          }
        end

        it 'returns true' do
          expect(subject.create_block?).to eq(true)
        end
      end

      context 'and collection routes are not passed' do
        let(:config) do
          {
            'additional_routes' => {
              'member' => [],
              'collection' => []
            }
          }
        end

        it 'returns false' do
          expect(subject.create_block?).to eq(false)
        end
      end
    end
  end
end
