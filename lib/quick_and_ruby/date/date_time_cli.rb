# frozen_string_literal: true

require_relative 'date_time_args'

module QuickAndRuby
  module Date
    # cli / main class for datetime utility
    #   usage example:
    #   - datetime -z <zone> -i <incr> -f "<format>" <from>|now <to>|now
    #   - datetime -z <zone> -i <incr> -f "<format>" <from>|now
    class DateTimeCli
      attr_reader :args

      def initialize(args: DateTimeArgs.ew(ARGV))
        @args = args
      end

      def run
        run_range if args.want_range?
        run_incr if args.want_incr?
      end

      def run_range
        DateRange.new(
        puts :RUN_RANGE
        time_cursor = args.date_begin
        while time_cursor <= args.date_end
          puts time_cursor.strftime(args.format)
          time_cursor.increment(**args.incr)
        end
      end

      def run_incr
        puts :RUN_INCR
      end
    end
  end
end
