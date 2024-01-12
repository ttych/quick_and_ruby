# frozen_string_literal: true

module QuickAndRuby
  class DistinguishedName
    attr_reader :attributes

    def initialize(attributes = [])
      @attributes = attributes
    end

    def to_s
      attributes.map(&:to_s).join(',')
    end

    def size
      @attributes.size
    end
    alias length size

    def reverse
      self.class.new(attributes.reverse)
    end

    def self.from_string(dn_str)
      attributes = dn_str.split(/(?<!\\),/).map do |dn_component|
        unless (match = /^([^=]+)=(.*)$/.match(dn_component.strip))
          raise "#{dn_component} is not a valid DistinguishedName component"
        end

        Attribute.new(*match.captures)
      end

      new(attributes)
    end

    class Attribute
      # DC 	domainComponent
      # CN 	commonName
      # OU 	organizationalUnitName
      # O 	organizationName
      # STREET 	streetAddress
      # L 	localityName
      # ST 	stateOrProvinceName
      # C 	countryName
      # UID 	userid

      attr_reader :attribute, :value

      def initialize(attribute, value)
        @attribute = attribute
        @value = value
      end

      def to_s
        "#{attribute}=#{value}"
      end
    end
  end
end
