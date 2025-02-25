# frozen_string_literal: true

require 'quick_and_ruby/time'

RSpec.describe QuickAndRuby::Time::EpochConverter do
  subject(:converter) { described_class.new(millis: millis, utc: utc) }

  let(:millis) { false }
  let(:utc) { false }

  describe '#convert' do
    describe 'from date to epoch' do
      it 'converts date time format' do
        expect(converter.convert('2025-01-01 01:01:01.000000000 +0100')).to eq(1_735_689_661)
      end

      it 'converts iso8601 date to epoch' do
        expect(converter.convert('2025-01-01T01:01:02.000+01:00')).to eq(1_735_689_662)
      end

      it 'converts UTC iso8601 date to epoch' do
        expect(converter.convert('2025-01-01T01:01:01.000Z')).to eq(1_735_693_261)
      end
    end

    describe 'from date to epoch millis' do
      let(:millis) { true }

      it 'converts date to epoch millis' do
        expect(converter.convert('2025-01-01T01:01:01.123Z')).to eq(1_735_693_261_123)
      end
    end

    describe 'from epoch to date' do
      it 'converts epoch to iso8601 format' do
        expect(converter.convert('1735689662')).to eq('2025-01-01T01:01:02.000+01:00')
      end

      it 'converts epoch millis to is8601 format' do
        expect(converter.convert('1735689661124')).to eq('2025-01-01T01:01:01.124+01:00')
      end
    end

    describe 'from epoch to date UTC' do
      let(:utc) { true }

      it 'converts epoch to UTC iso8601 format' do
        expect(converter.convert('1735693261')).to eq('2025-01-01T01:01:01.000Z')
      end

      it 'converts epoch millis to UTC iso8601 format' do
        expect(converter.convert('1735693261124')).to eq('2025-01-01T01:01:01.124Z')
      end
    end
  end
end
