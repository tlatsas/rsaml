require File.dirname(__FILE__) + '/../test_helper'

class BaseTest < Test::Unit::TestCase
  include RSAML::Binding
  context "Binding::Base" do
    subject { Base }
    context "encode" do
      should "return same string" do
        assert_equal "XML", subject.encode('XML')
      end
    end
    context "decode" do
      should "return same string" do
        assert_equal "XML", subject.decode('XML')
      end
    end
    context "authn_request" do
      subject {
        xml = <<XML
<?xml version="1.0" encoding="UTF-8"?>
<samlp:AuthnRequest xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                    ID="ID"
                    Version="2.0">
    <saml:Issuer xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">https://idp.example.com</saml:Issuer>
</samlp:AuthnRequest>
XML
        Base.authn_request(xml)
      }
      should "return a Protocol::AuthnRequest" do
        assert_kind_of RSAML::Protocol::AuthnRequest, subject
        assert_equal "ID", subject.id
      end
    end
  end
end
