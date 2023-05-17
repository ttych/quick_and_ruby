# frozen_string_literal: true

require 'date'
require 'optparse'

require 'quick_and_ruby/version'

module QuickAndRuby
  module Date
    # argv parser for datetime utility
    #   parsing example:
    #   - datetime -z <zone> -i <incr> -f "<format>" <from>|now <to>|now
    #   - datetime -z <zone> -i <incr> -f "<format>" <from>|now
    class DateTimeArgs
      DEFAULT_FORMAT = '%Y-%m-%dT%H:%M:%S.%3NZ'
      DEFAULT_INCR = '1d'
      DEFAULT_ZONE = DateTime.now.zone

      attr_reader :date_begin, :date_end, :incr, :format, :zone

      def initialize(date_begin: DateTime.now, date_end: nil,
                     incr: DEFAULT_INCR,
                     format: DEFAULT_FORMAT,
                     zone: DEFAULT_ZONE)
        @date_begin = date_begin
        @date_end = date_end
        @incr = incr
        @format = format
        @zone = zone
      end

      def want_range?
        date_begin && date_end
      end

      def want_incr?
        date_begin && !date_end
      end

      class << self
        def load(argv = ARGV)
          options = new
          parser(options).parse!(argv.clone)
          puts options
          options
        end

        private

        def parser(options)
          @parser ||= OptionParser.new do |opts|
            opts.banner = 'Usage: daterange [options] time-begin time-end'
            opts.on_tail('-h', '--help', 'Show this message') do
              puts opts
              exit
            end

            opts.on_tail('--version', 'Show version') do
              puts ::QuickAndRuby::VERSION
              exit
            end

            opts.on_tail('-f', '--format=FORMAT', 'FORMAT for printing date') do |format|
              options.format = format
            end

            opts.on_tail('-i', '--incr=INCR', 'Increment by INCR') do |incr|
              options.incr = incr
            end

            opts.on_tail('-z', '--zone=ZONE', 'Timezone ZONE') do |zone|
              options.zone = zone
            end
          end
        end
      end
    end
  end
end
