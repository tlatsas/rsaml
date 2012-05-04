require File.dirname(__FILE__) + '/../test_helper'

class AuthnRequestTest < Test::Unit::TestCase
  include RSAML::Protocol
  context "an authentication request instance" do
    setup do
      @request = AuthnRequest.new
    end
    should "be valid" do
      assert_nothing_raised { @request.validate }
    end
    context "#force_authn?" do
      should "be false when force_authn is false" do
        @request.force_authn = false
        assert_equal false, @request.force_authn?
      end
      should "be false when force_authn is nil" do
        @request.force_authn = nil
        assert_equal false, @request.force_authn?
      end
      should "be true when force_authn is true" do
        @request.force_authn = true
        assert_equal true, @request.force_authn?
      end
    end
    context "#passive?" do
      should "be false when is_passive is false" do
        @request.is_passive = false
        assert_equal false, @request.passive?
      end
      should "be false when is_passive is nil" do
        @request.is_passive = nil
        assert_equal false, @request.passive?
      end
      should "be true when is_passive is true" do
        @request.is_passive = true
        assert_equal true, @request.passive?
      end
    end
    context "when producing xml" do
      should "output the samlp:AuthnRequest element" do
        assert_match "<samlp:AuthnRequest xmlns:samlp=\"urn:oasis:names:tc:SAML:2.0:protocol\" xmlns:saml=\"urn:oasis:names:tc:SAML:2.0:assertion\"", @request.to_xml
      end
      should "optionally include a subject child" do
        @request.subject = Subject.new
        assert_match '<saml:Subject></saml:Subject>', @request.to_xml
      end
      should "optionally include a name id policy child" do
        name_id_policy = NameIdPolicy.new
        name_id_policy.format = Identifier::Name.formats[:email_address]
        @request.name_id_policy = name_id_policy
        assert_match '<samlp:NameIDPolicy Format="urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"', @request.to_xml
      end
      should "optionally include conditions" do
        conditions = Conditions.new
        @request.conditions = conditions
        assert_match '<saml:Conditions', @request.to_xml
      end
      should_eventually "optionally include requested authn context" do
        
      end
      should "optionally include scoping" do
        scoping = Scoping.new
        @request.scoping = scoping
        assert_match '<samlp:Scoping', @request.to_xml
      end
      should "optionally include force authn" do
        @request.force_authn = true
        assert_match '<samlp:AuthnRequest ForceAuthn="true"', @request.to_xml
      end
      should "optionally include passive flag" do
        @request.is_passive = true
        assert_match '<samlp:AuthnRequest IsPassive="true"', @request.to_xml
      end
      should "optionally include AssertionConsumerServiceURL" do
        
      end
      should "optionally include a provider name" do
        @request.provider_name = 'example'
        assert_match '<samlp:AuthnRequest ProviderName="example"', @request.to_xml
      end
    end
  end
end
