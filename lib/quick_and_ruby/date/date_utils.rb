# frozen_string_literal: true

require 'time'

module QuickAndRuby
  module Date
    module DateUtils
      DEFAULT_FORMAT = '%Y-%m-%dT%H:%M:%S.%3NZ'

      def self.now
        Time.now
      end
    end
  end
end

# time_start = DateTime.parse(ARGV[0])
# time_end = DateTime.parse(ARGV[1])

# class DateTime
#   def increment_by(year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0)
#     next_year(year)
#       .next_month(month)
#       .next_day(day) + Rational(hour, 24) + Rational(minute, 24 * 60) + Rational(second, 24 * 60 * 60)
#   end
# end

# while time_start <= time_end
#   puts time_start.strftime('%Y-%m-%dT%H:%M:%S.%3NZ')
#   time_start = time_start.increment(day: 1)
# end

# puts time_end.strftime('%Y-%m-%dT%H:%M:%S.%3NZ') if time_start < time_end
