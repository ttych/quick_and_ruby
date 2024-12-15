# frozen_string_literal: true

require_relative 'attribute'

module QuickAndRuby
  class DistinguishedName
    class OpensslFormat
      LABEL = :openssl
      SEPARATOR = '/'
      SPLIT_RE = %r{(?<!\\)/}.freeze

      def escape(value)
        value.gsub(%r{([/\\])}, '\\\\\1')
      end

      def unescape(value)
        value.gsub(%r{\\([/\\])}, '\1')
      end

      def recognize?(dn_str)
        return true if !dn_str || dn_str.empty?
        return true if dn_str.start_with?(SEPARATOR)

        false
      end

      def split(dn_str)
        dn_str = dn_str[1..] if dn_str.start_with?(SEPARATOR)

        parts = dn_str.split(SPLIT_RE)
        parts.map do |part|
          part = part.strip if part
          next if !part || part.empty?

          Attribute.from_s(part, unescaper: method(:unescape))
        end.compact
      end

      def join(attributes)
        SEPARATOR + attributes.map do |attribute|
          attribute.to_s(escaper: method(:escape))
        end.join(SEPARATOR)
      end
    end
  end
end
