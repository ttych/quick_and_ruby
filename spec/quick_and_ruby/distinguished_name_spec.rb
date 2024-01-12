# frozen_string_literal: true

require 'quick_and_ruby/distinguished_name'

RSpec.describe QuickAndRuby::DistinguishedName do
  let(:attr_cn) { described_class::Attribute.new('CN', 'Common Name') }
  let(:attr_ou) { described_class::Attribute.new('OU', 'Organizational Unit Name') }

  describe '.from_sring' do
    it 'can parse DN with single attribute' do
      dn_str = 'CN=Jeff Smith'
      dn = described_class.from_string(dn_str)

      expect(dn.to_s).to eq(dn_str)
    end

    it 'can parse DN with multiple attributes' do
      dn_str = 'CN=Jeff Smith,OU=Sales,DC=Fabrikam,DC=COM'
      dn = described_class.from_string(dn_str)

      expect(dn.to_s).to eq(dn_str)
    end

    it 'can parse DN with multiple CN attributes' do
      dn_str = 'CN=Karen Berge,CN=admin,DC=corp,DC=Fabrikam,DC=COM'
      dn = described_class.from_string(dn_str)

      expect(dn.to_s).to eq(dn_str)
    end

    it 'takes care to escaped comma in OU' do
      dn_str = 'CN=Litware,OU=Docs\, Adatum,DC=Fabrikam,DC=COM'
      dn = described_class.from_string(dn_str)

      expect(dn.to_s).to eq(dn_str)
    end

    it 'takes care to escaped comma in CN' do
      dn_str = 'CN=Surname\, Firstname (something),OU=Subdepartment,' \
               'OU=Department,OU=Fixed,OU=Fixed,DC=Fixed'
      dn = described_class.from_string(dn_str)

      expect(dn.to_s).to eq(dn_str)
    end
  end

  describe '#size' do
    it 'can extract 1 component for a simple DN' do
      dn = described_class.from_string('CN=Firstname Lastname')
      expect(dn.size).to eq(1)
    end

    it 'can extract 5 component for a complex DN' do
      dn_str = 'CN=Surname\, Firstname (something),OU=Subdepartment,' \
               'OU=Department,OU=Main,DC=Fixed'
      dn = described_class.from_string(dn_str)
      expect(dn.size).to eq(5)
    end
  end

  describe '#to_s' do
    it 'converts by default using the given order' do
      dn = described_class.new([attr_cn, attr_ou])

      expect(dn.to_s).to eq('CN=Common Name,OU=Organizational Unit Name')
    end
  end

  describe '#reverse' do
    it 'reverts the order of attributes' do
      dn = described_class.new([attr_cn, attr_ou])
      reverted_dn = dn.reverse

      expect(reverted_dn.to_s).to eq('OU=Organizational Unit Name,CN=Common Name')
    end
  end
end
