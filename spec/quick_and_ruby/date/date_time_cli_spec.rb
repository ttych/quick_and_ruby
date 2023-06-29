# frozen_string_literal: true

require 'quick_and_ruby/date'

# unit test for QuickAndRuby::Date::DateTimeCli
RSpec.describe QuickAndRuby::Date::DateTimeCli do
  subject { described_class.new(args) }
  let(:args) {}

  it 'can be run' do
    subject.run
  end
end
