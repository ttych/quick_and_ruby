# frozen_string_literal: true

require 'quick_and_ruby/distinguished_name'

RSpec.describe QuickAndRuby::DistinguishedName do
  let(:attr_cn) { described_class::Attribute.new('CN', 'Common Name') }
  let(:attr_ou) { described_class::Attribute.new('OU', 'Organizational Unit Name') }

  describe '.new' do
    describe 'RFC-formatted DN' do
      it 'can parse DN with single attribute' do
        dn_str = 'CN=Jeff Smith'
        dn = described_class.from_s(dn_str)

        expect(dn.to_s).to eq(dn_str)
      end

      it 'can parse DN with multiple attributes' do
        dn_str = 'CN=Jeff Smith,OU=Sales,DC=Fabrikam,DC=COM'
        dn = described_class.from_s(dn_str)

        expect(dn.to_s).to eq(dn_str)
      end

      it 'can parse DN with multiple CN attributes' do
        dn_str = 'CN=Karen Berge,CN=admin,DC=corp,DC=Fabrikam,DC=COM'
        dn = described_class.from_s(dn_str)

        expect(dn.to_s).to eq(dn_str)
      end

      it 'takes care to escaped comma in OU' do
        dn_str = 'CN=Litware,OU=Docs\, Adatum,DC=Fabrikam,DC=COM'
        dn = described_class.from_s(dn_str)

        expect(dn.to_s).to eq(dn_str)
      end

      it 'takes care to escaped comma in CN' do
        dn_str = 'CN=Surname\, Firstname (something),OU=Subdepartment,' \
                 'OU=Department,OU=Fixed,OU=Fixed,DC=Fixed'
        dn = described_class.from_s(dn_str)

        expect(dn.to_s).to eq(dn_str)
      end
    end

    describe 'OpenSSL-formatted DN' do
      it 'can parse DN with single attribute' do
        dn_str_openssl = '/CN=Jeff Smith'
        dn_str_rfc = 'CN=Jeff Smith'
        dn = described_class.from_s(dn_str_openssl)

        expect(dn.to_s).to eq(dn_str_rfc)
        expect(dn.to_s(format: :openssl)).to eq(dn_str_openssl)
      end

      it 'can parse DN with multiple attributes' do
        dn_str_openssl = '/CN=Jeff Smith/OU=Sales/DC=Fabrikam/DC=COM'
        dn_str_rfc = 'CN=Jeff Smith,OU=Sales,DC=Fabrikam,DC=COM'
        dn = described_class.from_s(dn_str_openssl)

        expect(dn.to_s).to eq(dn_str_rfc)
        expect(dn.to_s(format: :openssl)).to eq(dn_str_openssl)
      end

      it 'can parse DN with multiple CN attributes' do
        dn_str_openssl = '/CN=Karen Berge/CN=admin/DC=corp/DC=Fabrikam/DC=COM'
        dn_str_rfc = 'CN=Karen Berge,CN=admin,DC=corp,DC=Fabrikam,DC=COM'
        dn = described_class.from_s(dn_str_openssl)

        expect(dn.to_s).to eq(dn_str_rfc)
        expect(dn.to_s(format: :openssl)).to eq(dn_str_openssl)
      end

      it 'takes care to escaped comma in OU' do
        dn_str_openssl = '/CN=Litware/OU=Docs, Adatum/DC=Fabrikam/DC=COM'
        dn_str_rfc = 'CN=Litware,OU=Docs\, Adatum,DC=Fabrikam,DC=COM'
        dn = described_class.from_s(dn_str_openssl)

        expect(dn.to_s).to eq(dn_str_rfc)
        expect(dn.to_s(format: :openssl)).to eq(dn_str_openssl)
      end

      it 'takes care to escaped comma in CN' do
        dn_str_openssl = '/CN=Surname, Firstname (something)/OU=Subdepartment/' \
                         'OU=Department/OU=Fixed/OU=Fixed/DC=Fixed'
        dn_str_rfc = 'CN=Surname\\, Firstname (something),OU=Subdepartment,' \
                     'OU=Department,OU=Fixed,OU=Fixed,DC=Fixed'
        dn = described_class.from_s(dn_str_openssl)

        expect(dn.to_s).to eq(dn_str_rfc)
        expect(dn.to_s(format: :openssl)).to eq(dn_str_openssl)
      end
    end
  end

  describe '#size' do
    it 'can extract 1 component for a simple DN' do
      dn = described_class.from_s('CN=Firstname Lastname')
      expect(dn.size).to eq(1)
    end

    it 'can extract 5 component for a complex DN' do
      dn_str = 'CN=Surname\, Firstname (something),OU=Subdepartment,' \
               'OU=Department,OU=Main,DC=Fixed'
      dn = described_class.from_s(dn_str)
      expect(dn.size).to eq(5)
    end
  end

  describe '#to_s' do
    it 'generates by default RFC format' do
      dn = described_class.new([attr_cn, attr_ou])

      expect(dn.to_s).to eq('CN=Common Name,OU=Organizational Unit Name')
    end

    it 'can generate RFC formatted string' do
      dn = described_class.new([attr_cn, attr_ou])

      expect(dn.to_s(format: :rfc)).to eq('CN=Common Name,OU=Organizational Unit Name')
    end

    it 'can generate OpenSSL formatted string' do
      dn = described_class.new([attr_cn, attr_ou])

      expect(dn.to_s(format: :openssl)).to eq('/CN=Common Name/OU=Organizational Unit Name')
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
