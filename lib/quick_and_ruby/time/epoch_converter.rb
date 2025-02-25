# frozen_string_literal: true

require 'time'

module QuickAndRuby
  module Time
    class EpochConverter
      attr_reader :millis, :utc

      def initialize(millis:, utc:)
        @millis = millis
        @utc = utc
      end

      def convert_all(*values)
        values.map { |value_str| convert(value_str) }
      end

      def convert(value_str)
        if value_str.match(/\D/)
          convert_time(value_str)
        else
          convert_epoch(value_str)
        end
      end

      def convert_time(time_str)
        time = ::Time.parse(time_str)
        epoch = time.to_f
        epoch *= 1000 if millis
        epoch.to_i
      end

      def convert_epoch(epoch_str)
        epoch = epoch_str.to_i
        epoch /= 1000.0 if epoch_str.size > 10
        time = ::Time.at(epoch)
        time = time.utc if utc
        time.iso8601(3)
      end
    end
  end
end
