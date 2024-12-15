# frozen_string_literal: true

require_relative 'distinguished_name/attribute'
require_relative 'distinguished_name/rfc_format'
require_relative 'distinguished_name/openssl_format'

module QuickAndRuby
  class DistinguishedName
    attr_reader :attributes

    def initialize(attributes = [])
      @attributes = attributes
    end

    def to_s(format: :rfc)
      formatter = get_format(format)
      formatter.join(attributes)
    end

    def reverse
      self.class.new(attributes.reverse)
    end

    def size
      attributes.size
    end
    alias length size

    def get_format(label = :rfc)
      self.class.get_format(label)
    end

    class << self
      def from_s(dn_str, format: nil)
        return new if !dn_str || dn_str.empty?

        formatter ||= get_format(format) if format
        formatter ||= openssl_format if openssl_format.recognize?(dn_str)
        formatter ||= rfc_format

        attributes = formatter.split(dn_str)

        new(attributes)
      end

      def rfc_format
        get_format(:rfc)
      end

      def openssl_format
        get_format(:openssl)
      end

      def get_format(label = :rfc)
        case label.to_sym
        when :rfc
          RfcFormat.new
        when :openssl
          OpensslFormat.new
        else
          raise ArgumentError, "Unsupported format #{label}"
        end
      end
    end
  end
end
