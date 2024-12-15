# frozen_string_literal: true

require_relative 'attribute'

module QuickAndRuby
  class DistinguishedName
    class RfcFormat
      LABEL = :rfc
      SEPARATOR = ','
      SPLIT_RE = /(?<!\\),/.freeze

      UNESCAPE_ALL_RE = /\\(.)/.freeze

      def escape(value)
        # value.gsub(/([,\\+<>;"= ])/, '\\\1')
        value.gsub(/([,\\+<>;"=])/, '\\\\\1')
      end

      def unescape(value)
        # .gsub(UNESCAPE_ALL_RE, '\1')
        value.gsub(/\\([,\\+<>;"= ])/, '\1')
      end

      def recognize?(dn_str)
        return true if !dn_str || dn_str.empty?

        true
      end

      def split(dn_str)
        parts = dn_str.split(SPLIT_RE)
        parts.map do |part|
          part = part.strip if part
          next if !part || part.empty?

          Attribute.from_s(part, unescaper: method(:unescape))
        end.compact
      end

      def join(attributes)
        attributes.map do |attribute|
          attribute.to_s(escaper: method(:escape))
        end.join(SEPARATOR)
      end
    end
  end
end
