# frozen_string_literal: true

RSpec.describe QuickAndRuby::Proxy::ArgParser do
  subject { described_class.new(argv) }

  context 'with empty ARGV' do
    let(:argv) { [] }

    it 'parses empty ARGV to default values' do
      default_options = { verbose: false,
                          bind: '0.0.0.0',
                          port: 8080 }

      parsed_options = subject.parse
      expect(default_options).to eq(parsed_options)
    end
  end
end
