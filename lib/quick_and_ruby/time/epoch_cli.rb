# frozen_string_literal: true

require 'optparse'

# Usage example:
#
# epoch
#   => 1740485717
# epoch -ms
#   => 1740485775670
# epoch 1740485717
#   => 2025-02-25T13:17:14.508+01:00
# epoch -u 1740485717
#   => 2025-02-25T12:18:21.954Z
# epoch [-d|--diff] 1740485717
#   => 30sec ago
# epoch [-v|--verbose] 1740485717
#   => 2025-02-25T12:18:21.954Z
#   => 30sec ago

module QuickAndRuby
  module Time
    class EpochCli
      attr_reader :argv, :env

      def initialize(argv: ARGV, env: ENV)
        @argv = argv.clone
        @env = env.to_h.clone
      end

      def run
        options = parse_options
        puts EpochConverter.new(**options.to_h).convert_all(*argv)
      end

      def parse_options(options: Options.new)
        parser = OptionParser.new do |opts|
          opts.banner = 'Usage: epoch [options]'

          opts.on('-h', '--help', 'Prints this help') do
            puts parser
            exit
          end

          opts.on('-m', '--millis', 'Display epoch in milliseconds') do |_millis|
            options.millis = true
          end

          opts.on('-u', '--utc', 'Display time in UTC') do
            options.utc = true
          end
        end

        parser.parse!(argv)
        options
      end

      class Options
        DEFAULT_MILLIS = false
        DEFAULT_UTC = false

        attr_accessor :millis, :utc

        def initialize(millis: DEFAULT_MILLIS, utc: DEFAULT_UTC)
          @millis = millis
          @utc = utc
        end

        def to_h
          { millis: millis,
            utc: utc }
        end
      end
    end
  end
end
