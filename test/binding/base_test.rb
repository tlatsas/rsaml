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
    context "message_data" do
      setup do
        @authn_request = RSAML::Protocol::Response.new(RSAML::Protocol::Status.new(RSAML::Protocol::StatusCode.new(:success)))
        @authn_request.id = 'b0505560-8236-012f-4621-00242131fa16'
        @authn_request.issue_instant = Time.parse('2012-05-17T10:12:10Z')
        assertion = RSAML::Assertion.new(RSAML::Identifier::Issuer.new("http://example.com"))
        assertion.id = 'b0506170-8236-012f-4622-00242131fa16'
        assertion.issue_instant = Time.parse('2012-05-17T10:12:10Z')
        @authn_request.assertions << assertion
      end
      context 'with not an actual Protocol::Message' do
        [nil, 'text', RSAML::Audience.new('foo')].each do |message|
          should "raise ArgumentError with #{message.class}" do
            assert_raises ArgumentError do
              subject.message_data(message)
            end
          end
        end
      end
      context 'with default options' do
        subject { Base.message_data(@authn_request) }
        should 'be valid xml document pretty printed' do
          expected_xml = <<XML
<?xml version='1.0' encoding='UTF-8'?>
<samlp:Response ID='b0505560-8236-012f-4621-00242131fa16' Version='2.0' IssueInstant='2012-05-17T10:12:10Z' xmlns:samlp='urn:oasis:names:tc:SAML:2.0:protocol' xmlns:saml='urn:oasis:names:tc:SAML:2.0:assertion'>
    <samlp:Status>
        <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:Success'/>
    </samlp:Status>
    <saml:Assertion ID='b0506170-8236-012f-4622-00242131fa16' Version='2.0' IssueInstant='2012-05-17T10:12:10Z'>
        <saml:Issuer Format='urn:oasis:names:tc:SAML:2.0:nameid-format:entity'>
            http://example.com
        </saml:Issuer>
    </saml:Assertion>
</samlp:Response>
XML
          assert_equal expected_xml.strip, subject.strip
        end
      end
      context 'with pretty print explicitly off' do
        subject { Base.message_data(@authn_request, :pretty => false) }
        should 'be valid xml document one liner' do
          expected_xml = <<XML
<?xml version="1.0" encoding="UTF-8"?><samlp:Response ID="b0505560-8236-012f-4621-00242131fa16" Version="2.0" IssueInstant="2012-05-17T10:12:10Z" xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol" xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"><samlp:Status><samlp:StatusCode Value="urn:oasis:names:tc:SAML:2.0:status:Success"></samlp:StatusCode></samlp:Status><saml:Assertion ID="b0506170-8236-012f-4622-00242131fa16" Version="2.0" IssueInstant="2012-05-17T10:12:10Z"><saml:Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity">http://example.com</saml:Issuer></saml:Assertion></samlp:Response>
XML
          assert_equal expected_xml.strip, subject.strip
        end
      end
      context 'with pretty print explicitly on' do
        subject { Base.message_data(@authn_request, :pretty => true) }
        should 'be valid xml document pretty printed' do
          expected_xml = <<XML
<?xml version='1.0' encoding='UTF-8'?>
<samlp:Response ID='b0505560-8236-012f-4621-00242131fa16' Version='2.0' IssueInstant='2012-05-17T10:12:10Z' xmlns:samlp='urn:oasis:names:tc:SAML:2.0:protocol' xmlns:saml='urn:oasis:names:tc:SAML:2.0:assertion'>
    <samlp:Status>
        <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:Success'/>
    </samlp:Status>
    <saml:Assertion ID='b0506170-8236-012f-4622-00242131fa16' Version='2.0' IssueInstant='2012-05-17T10:12:10Z'>
        <saml:Issuer Format='urn:oasis:names:tc:SAML:2.0:nameid-format:entity'>
            http://example.com
        </saml:Issuer>
    </saml:Assertion>
</samlp:Response>
XML
          assert_equal expected_xml.strip, subject.strip
        end
      end
    end
  end
end
