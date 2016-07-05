require File.dirname(__FILE__) + '/../test_helper'

class LogoutRequestTest < MiniTest::Test
  include RSAML::Protocol

  context "a logout request instance" do
    context "when producing xml" do
      setup do
        @request = LogoutRequest.new
      end

      should "output a sampl:LogoutRequest element" do
        assert_match "<samlp:LogoutRequest xmlns:samlp=\"urn:oasis:names:tc:SAML:2.0:protocol\" xmlns:saml=\"urn:oasis:names:tc:SAML:2.0:assertion\"></samlp:LogoutRequest>", @request.to_xml
      end

      should "have an issuer" do
        @request.issuer = Identifier::Issuer.new('urn:mace:feide.no:services:no.feide.foodle')
        assert_match 'urn:mace:feide.no:services:no.feide.foodle</saml:Issuer>', @request.to_xml
      end

      should "have a name id" do
        @request.name = Identifier::Name.new('_6a171f538d4f733ae95eca74ce264cfb602808c850')
        assert_match '_6a171f538d4f733ae95eca74ce264cfb602808c850</saml:NameID>', @request.to_xml
      end
    end
  end

  context "from xml" do
    context "with simpleSAMLphp" do
      setup do
        request_xml = <<XML
<samlp:LogoutRequest
xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"
ID="_72424ea37e28763e351189529639b9c2b150ff37e5" Version="2.0"
Destination="https://openidp.feide.no/simplesaml/saml2/idp/SingleLogoutService.php"
IssueInstant="2008-06-03T12:59:57Z">
<saml:Issuer >urn:mace:feide.no:services:no.feide.foodle</saml:Issuer>
<saml:NameID Format="urn:oasis:names:tc:SAML:2.0:nameid-format:transient" SPNameQualifier="urn:mace:feide.no:services:no.feide.foodle">_6a171f538d4f733ae95eca74ce264cfb602808c850</saml:NameID>
<samlp:SessionIndex>_b976de57fcf0f707de297069f33a6b0248827d96a9</samlp:SessionIndex>
</samlp:LogoutRequest>
XML

        @request = LogoutRequest.from_xml(request_xml)
      end

      should "have id set to '_72424ea37e28763e351189529639b9c2b150ff37e5'"do
        assert_equal '_72424ea37e28763e351189529639b9c2b150ff37e5', @request.id
      end

      should "have version set to '2.0'" do
        assert_equal '2.0', @request.version
      end

      should "have issue_instant set to '2008-06-03T12:59:57Z'" do
        assert_not_nil @request.issue_instant
        assert_kind_of Time, @request.issue_instant
        assert_equal '2008-06-03T12:59:57Z', @request.issue_instant.iso8601
      end

      should "have destination set to 'https://openidp.feide.no/simplesaml/saml2/idp/SingleLogoutService.php'" do
        assert_equal 'https://openidp.feide.no/simplesaml/saml2/idp/SingleLogoutService.php', @request.destination
      end

      should "have issuer" do
        assert_not_nil @request.issuer
        assert_equal 'urn:mace:feide.no:services:no.feide.foodle', @request.issuer.value
      end

      should "have name" do
        assert_not_nil @request.name
        assert_equal '_6a171f538d4f733ae95eca74ce264cfb602808c850', @request.name.value
        assert_equal 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient', @request.name.format
        assert_equal 'urn:mace:feide.no:services:no.feide.foodle', @request.name.sp_name_qualifier
      end
    end
  end
end
