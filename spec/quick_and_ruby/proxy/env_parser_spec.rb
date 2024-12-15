# frozen_string_literal: true

RSpec.describe QuickAndRuby::Proxy::EnvParser do
  subject { described_class.new(env) }

  context 'with empty ENV' do
    let(:env) { {} }

    it 'generates empty options' do
      expect(subject.parse).to eq({})
    end
  end

  context 'with HTTP_PROXY in ENV' do
    let(:env) { { 'HTTP_PROXY' => 'http://user:password@proxy:12345' } }

    it 'extracts proxy args from environment' do
      expected_options = { proxy_host: 'proxy',
                           proxy_port: '12345',
                           user: 'user:password' }
      expect(subject.parse).to eq(expected_options)
    end
  end
end
