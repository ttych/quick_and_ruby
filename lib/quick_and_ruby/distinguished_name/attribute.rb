# frozen_string_literal: true

module QuickAndRuby
  class DistinguishedName
    class Attribute
      # DC  domainComponent
      # CN  commonName
      # OU  organizationalUnitName
      # O   organizationName
      # STREET  streetAddress
      # L   localityName
      # ST  stateOrProvinceName
      # C   countryName
      # UID userid

      SPLIT_RE = /^(\w+)=((?:\\.|[^\\])+)$/.freeze

      attr_reader :name, :value

      def initialize(name, value)
        @name = name
        @value = value
      end

      def to_s(escaper: nil)
        escaped_value = value
        escaped_value = escaper.call(escaped_value) if escaper

        "#{name}=#{escaped_value}"
      end

      def self.from_s(part, unescaper: nil)
        unless (match = SPLIT_RE.match(part))
          raise "Invalid DN part: '#{part}'"
        end

        key = match[1].strip
        value = match[2].strip
        unescaped_value = value
        unescaped_value = unescaper.call(unescaped_value) if unescaper
        new(key, unescaped_value)
      end
    end
  end
end
