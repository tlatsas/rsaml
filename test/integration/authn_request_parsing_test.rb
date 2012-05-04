require File.dirname(__FILE__) + '/../test_helper'

class AuthnRequestParsingTest < Test::Unit::TestCase
  include RSAML::Protocol
  context "with Google Apps" do
    setup do
      request_xml = <<XML
<?xml version="1.0" encoding="UTF-8"?>
<samlp:AuthnRequest xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                    ID="djikeehkdinmglljlaeianmgabajfnplkldoamkl"
                    Version="2.0"
                    IssueInstant="2008-05-27T08:19:29Z"
                    ProtocolBinding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
                    ProviderName="google.com"
                    AssertionConsumerServiceURL="https://www.google.com/a/example.com/acs"
                    IsPassive="false">
    <saml:Issuer xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">google.com</saml:Issuer>
    <samlp:NameIDPolicy AllowCreate="true"
                        Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified"/>
</samlp:AuthnRequest>
XML
      @request = AuthnRequest.from_xml(request_xml)
    end

    should "have id set to 'djikeehkdinmglljlaeianmgabajfnplkldoamkl'" do
      assert_equal 'djikeehkdinmglljlaeianmgabajfnplkldoamkl', @request.id
    end
    should "have version set to '2.0'" do
      assert_equal '2.0', @request.version
    end
    should "have issue_instant set to '2008-05-27T08:19:29Z'" do
      assert_not_nil @request.issue_instant
      assert_kind_of Time, @request.issue_instant
      assert_equal '2008-05-27T08:19:29Z', @request.issue_instant.iso8601
    end
    should "have protocol_binding set to 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST'" do
      assert_equal 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST', @request.protocol_binding
    end
    should "have provider_name set to 'google.com'" do
      assert_equal 'google.com', @request.provider_name
    end
    should "have assertion_consumer_service_url set to 'https://www.google.com/a/example.com/acs'" do
      assert_equal 'https://www.google.com/a/example.com/acs', @request.assertion_consumer_service_url
    end
    should "have is_passive set to false" do
      assert_equal false, @request.is_passive
    end
    should "have passive? set to false" do
      assert_equal false, @request.passive?
    end
    should "have issuer" do
      assert_not_nil @request.issuer
      assert_equal 'google.com', @request.issuer.value
    end
    should "have name_id_policy" do
      assert_not_nil @request.name_id_policy
      assert_equal true, @request.name_id_policy.allow_create
      assert_equal 'urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified', @request.name_id_policy.format
    end
  end
  context "with mod_mellon" do
    setup do
      request_xml = <<XML
<samlp:AuthnRequest xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                    xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"
                    ID="_116346E65D6B4F0F9EE6AAA49D90523C"
                    Version="2.0"
                    IssueInstant="2008-05-27T08:25:23Z"
                    Consent="urn:oasis:names:tc:SAML:2.0:consent:current-implicit"
                    ForceAuthn="false"
                    IsPassive="false">
    <saml:Issuer>urn:mace:feide.no:services:no.uninett.maidentest</saml:Issuer>
    <samlp:NameIDPolicy Format="urn:oasis:names:tc:SAML:2.0:nameid-format:transient"
                        SPNameQualifier="urn:mace:feide.no:services:no.uninett.maidentest"
                        AllowCreate="true"/>
</samlp:AuthnRequest>
XML
      @request = AuthnRequest.from_xml(request_xml)
    end

    should "have id set to '_116346E65D6B4F0F9EE6AAA49D90523C'" do
      assert_equal '_116346E65D6B4F0F9EE6AAA49D90523C', @request.id
    end
    should "have version set to '2.0'" do
      assert_equal '2.0', @request.version
    end
    should "have issue_instant set to '2008-05-27T08:25:23Z'" do
      assert_not_nil @request.issue_instant
      assert_kind_of Time, @request.issue_instant
      assert_equal '2008-05-27T08:25:23Z', @request.issue_instant.iso8601
    end
    should "have consent set to 'urn:oasis:names:tc:SAML:2.0:consent:current-implicit'" do
      assert_equal 'urn:oasis:names:tc:SAML:2.0:consent:current-implicit', @request.consent
    end
    should "have force_authn set to false" do
      assert_equal false, @request.force_authn
    end
    should "have force_authn? set to false" do
      assert_equal false, @request.force_authn?
    end
    should "have is_passive set to false" do
      assert_equal false, @request.is_passive
    end
    should "have passive? set to false" do
      assert_equal false, @request.passive?
    end
    should "have issuer" do
      assert_not_nil @request.issuer
      assert_equal 'urn:mace:feide.no:services:no.uninett.maidentest', @request.issuer.value
    end
    should "have name_id_policy" do
      assert_not_nil @request.name_id_policy
      assert_equal true, @request.name_id_policy.allow_create
      assert_equal 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient', @request.name_id_policy.format
      assert_equal 'urn:mace:feide.no:services:no.uninett.maidentest', @request.name_id_policy.sp_name_qualifier
    end
  end
  context "with omniauth-saml" do
    setup do
      request_xml = <<XML
<samlp:AuthnRequest xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                    ID="_e7cbede0-6477-012f-549c-00242131fa16"
                    Version="2.0"
                    IssueInstant="2012-04-09T13:43:25Z"
                    ProtocolBinding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
                    AssertionConsumerServiceURL="http://example.com/auth/saml/callback">
    <saml:Issuer xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">OmniAuthSAML</saml:Issuer>
    <samlp:NameIDPolicy xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                        Format="urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
                        AllowCreate="true"></samlp:NameIDPolicy>
    <samlp:RequestedAuthnContext xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol" Comparison="exact">
        <saml:AuthnContextClassRef xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">
            urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport
        </saml:AuthnContextClassRef>
    </samlp:RequestedAuthnContext>
</samlp:AuthnRequest>
XML
      @request = AuthnRequest.from_xml(request_xml)
    end

    should "have id set to '_e7cbede0-6477-012f-549c-00242131fa16'" do
      assert_equal '_e7cbede0-6477-012f-549c-00242131fa16', @request.id
    end
    should "have version set to '2.0'" do
      assert_equal '2.0', @request.version
    end
    should "have issue_instant set to '2012-04-09T13:43:25Z'" do
      assert_not_nil @request.issue_instant
      assert_kind_of Time, @request.issue_instant
      assert_equal '2012-04-09T13:43:25Z', @request.issue_instant.iso8601
    end
    should "have protocol_binding set to 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST'" do
      assert_equal 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST', @request.protocol_binding
    end
    should "have assertion_consumer_service_url set to 'http://example.com/auth/saml/callback'" do
      assert_equal 'http://example.com/auth/saml/callback', @request.assertion_consumer_service_url
    end
    should "have force_authn? set to false" do
      assert_equal false, @request.force_authn?
    end
    should "have passive? set to false" do
      assert_equal false, @request.passive?
    end
    should "have issuer" do
      assert_not_nil @request.issuer
      assert_equal 'OmniAuthSAML', @request.issuer.value
    end
    should "have name_id_policy" do
      assert_not_nil @request.name_id_policy
      assert_equal true, @request.name_id_policy.allow_create
      assert_equal 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress', @request.name_id_policy.format
    end
    should "have requested_authn_context"
  end
  context "with Ping Federate" do
    setup do
      request_xml = <<XML
<AuthnRequest Destination="http://idp.ssocircle.com:80/sso/SSORedirect/metaAlias/ssocircle"
              IssueInstant="2008-05-28T20:12:35.971Z"
              ID="xc6YVsq0cxOWkwdDqQwqCIMmHSu"
              Version="2.0"
              xmlns="urn:oasis:names:tc:SAML:2.0:protocol"
              xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">
    <saml:Issuer>edugain.showcase.surfnet.nl</saml:Issuer>
    <NameIDPolicy AllowCreate="true"/>
</AuthnRequest>
XML
      @request = AuthnRequest.from_xml(request_xml)
    end

    should "have id set to 'xc6YVsq0cxOWkwdDqQwqCIMmHSu'" do
      assert_equal 'xc6YVsq0cxOWkwdDqQwqCIMmHSu', @request.id
    end
    should "have version set to '2.0'" do
      assert_equal '2.0', @request.version
    end
    should "have issue_instant set to '2008-05-28T20:12:35.971Z'" do
      assert_not_nil @request.issue_instant
      assert_kind_of Time, @request.issue_instant
      assert_equal '2008-05-28T20:12:35Z', @request.issue_instant.iso8601
    end
    should "have destination set to 'http://idp.ssocircle.com:80/sso/SSORedirect/metaAlias/ssocircle'" do
      assert_equal 'http://idp.ssocircle.com:80/sso/SSORedirect/metaAlias/ssocircle', @request.destination
    end
    should "force_authn passive? set to false" do
      assert_equal false, @request.force_authn?
    end
    should "have passive? set to false" do
      assert_equal false, @request.passive?
    end
    should "have issuer" do
      assert_not_nil @request.issuer
      assert_equal 'edugain.showcase.surfnet.nl', @request.issuer.value
    end
    should "have name_id_policy" do
      assert_not_nil @request.name_id_policy
      assert_equal true, @request.name_id_policy.allow_create
    end
  end
  context "with simpleSAMLphp" do
    setup do
      request_xml = <<XML
<samlp:AuthnRequest xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                    xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"
                    ID="_d7607d551380ac97853a6ff4907c4ef01219be97dd"
                    Version="2.0"
                    IssueInstant="2008-05-27T07:46:06Z"
                    ForceAuthn="true"
                    IsPassive="false"
                    Destination="https://openidp.feide.no/simplesaml/saml2/idp/SSOService.php"
                    ProtocolBinding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
                    AssertionConsumerServiceURL="http://dev.andreas.feide.no/simplesaml/saml2/sp/AssertionConsumerService.php">
    <saml:Issuer>http://dev.andreas.feide.no/simplesaml/saml2/sp/metadata.php</saml:Issuer>
    <samlp:NameIDPolicy Format="urn:oasis:names:tc:SAML:2.0:nameid-format:transient"
                        AllowCreate="true"/>
</samlp:AuthnRequest>
XML
      @request = AuthnRequest.from_xml(request_xml)
    end

    should "have id set to '_d7607d551380ac97853a6ff4907c4ef01219be97dd'" do
      assert_equal '_d7607d551380ac97853a6ff4907c4ef01219be97dd', @request.id
    end
    should "have version set to '2.0'" do
      assert_equal '2.0', @request.version
    end
    should "have issue_instant set to '2008-05-27T07:46:06Z'" do
      assert_not_nil @request.issue_instant
      assert_kind_of Time, @request.issue_instant
      assert_equal '2008-05-27T07:46:06Z', @request.issue_instant.iso8601
    end
    should "have destination set to 'https://openidp.feide.no/simplesaml/saml2/idp/SSOService.php'" do
      assert_equal 'https://openidp.feide.no/simplesaml/saml2/idp/SSOService.php', @request.destination
    end
    should "have force_authn set to true" do
      assert_equal true, @request.force_authn
    end
    should "have force_authn? set to false" do
      assert_equal true, @request.force_authn?
    end
    should "have is_passive set to false" do
      assert_equal false, @request.is_passive
    end
    should "have passive? set to false" do
      assert_equal false, @request.passive?
    end
    should "have protocol_binding set to 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST'" do
      assert_equal 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST', @request.protocol_binding
    end
    should "have assertion_consumer_service_url set to 'http://dev.andreas.feide.no/simplesaml/saml2/sp/AssertionConsumerService.php'" do
      assert_equal 'http://dev.andreas.feide.no/simplesaml/saml2/sp/AssertionConsumerService.php', @request.assertion_consumer_service_url
    end
    should "have issuer" do
      assert_not_nil @request.issuer
      assert_equal 'http://dev.andreas.feide.no/simplesaml/saml2/sp/metadata.php', @request.issuer.value
    end
    should "have name_id_policy" do
      assert_not_nil @request.name_id_policy
      assert_equal true, @request.name_id_policy.allow_create
      assert_equal 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient', @request.name_id_policy.format
    end
  end
end
