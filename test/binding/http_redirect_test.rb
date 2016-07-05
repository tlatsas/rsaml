require File.dirname(__FILE__) + '/../test_helper'

class HTTPRedirectTest < MiniTest::Test
  include RSAML::Binding

  context 'RSAML::Binding::HTTPRedirect' do
    subject { RSAML::Binding::HTTPRedirect }
    should 'have identification set to "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"' do
      assert_equal 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect', subject.identification
    end
    should 'encode according to the spec' do
      xml = <<XML
<?xml version="1.0" encoding="UTF-8"?>
<samlp:AuthnRequest xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                    ID="djikeehkdinmglljlaeianmgabajfnplkldoamkl"
                    Version="2.0"
                    IssueInstant="2008-05-27T08:19:29Z"
                    ProtocolBinding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"
                    ProviderName="LocalTest"
                    AssertionConsumerServiceURL="http://localhost:3000/sp/acs"
                    IsPassive="true">
    <saml:Issuer xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">http://localhost:3000</saml:Issuer>
</samlp:AuthnRequest>
XML
      encoded_xml = "fVJBbsIwELzzisj3EENVFSwSRFtVRaIVgtBDb8bZEhPHTr1O1OfXDSAhNcGn%0AlTw7Mzu7s%2FlPqYIGLEqjYzIaUhKAFiaT%2BhCTXfoSTsg8GcyQl6pii9rlegPf%0ANaALfKNG1n7EpLaaGY4SmeYlIHOCbRdvKzYeUlZZ44wwigyCjrd8jkl2lAVA%0AXnjV8qDUUXGQ3Jd8z49fulKFygwvix6Gj4t7L9ajgVjDUqPj2nkYpZOQ3ofj%0Ah5RO2GjKxtPP7r712fmj1KdAbo25P4GQvabpOtxAJi0I10vcyAzsu2eJycoI%0ArlKfaTd4gQjW%2BQmfjMa6BLsF20gBu80qJrlzFYsi9UeRG3TsjlIaYRVxgX1h%0ArDmibLywszWQpEW1G2ZtUPZqtbdH5hdnJOn0MYuuWP0VRf%2FPKBn8Ag%3D%3D%0A"
      assert_equal encoded_xml, subject.encode(xml)
    end
    should 'decode according to the spec' do
      xml = <<XML
<?xml version="1.0" encoding="UTF-8"?>
<samlp:AuthnRequest xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                    ID="djikeehkdinmglljlaeianmgabajfnplkldoamkl"
                    Version="2.0"
                    IssueInstant="2008-05-27T08:19:29Z"
                    ProtocolBinding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"
                    ProviderName="LocalTest"
                    AssertionConsumerServiceURL="http://localhost:3000/sp/acs"
                    IsPassive="true">
    <saml:Issuer xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">http://localhost:3000</saml:Issuer>
</samlp:AuthnRequest>
XML
      encoded_xml = "fVJBbsIwELzzisj3EENVFSwSRFtVRaIVgtBDb8bZEhPHTr1O1OfXDSAhNcGn%0AlTw7Mzu7s%2FlPqYIGLEqjYzIaUhKAFiaT%2BhCTXfoSTsg8GcyQl6pii9rlegPf%0ANaALfKNG1n7EpLaaGY4SmeYlIHOCbRdvKzYeUlZZ44wwigyCjrd8jkl2lAVA%0AXnjV8qDUUXGQ3Jd8z49fulKFygwvix6Gj4t7L9ajgVjDUqPj2nkYpZOQ3ofj%0Ah5RO2GjKxtPP7r712fmj1KdAbo25P4GQvabpOtxAJi0I10vcyAzsu2eJycoI%0ArlKfaTd4gQjW%2BQmfjMa6BLsF20gBu80qJrlzFYsi9UeRG3TsjlIaYRVxgX1h%0ArDmibLywszWQpEW1G2ZtUPZqtbdH5hdnJOn0MYuuWP0VRf%2FPKBn8Ag%3D%3D%0A"
      assert_equal xml, subject.decode(encoded_xml)
    end
    should 'skip unescape on decode if asked' do
      xml = <<XML
<?xml version="1.0" encoding="UTF-8"?>
<samlp:AuthnRequest xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                    ID="djikeehkdinmglljlaeianmgabajfnplkldoamkl"
                    Version="2.0"
                    IssueInstant="2008-05-27T08:19:29Z"
                    ProtocolBinding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"
                    ProviderName="LocalTest"
                    AssertionConsumerServiceURL="http://localhost:3000/sp/acs"
                    IsPassive="true">
    <saml:Issuer xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">http://localhost:3000</saml:Issuer>
</samlp:AuthnRequest>
XML
      encoded_xml = "fVJBbsIwELzzisj3EENVFSwSRFtVRaIVgtBDb8bZEhPHTr1O1OfXDSAhNcGn%0AlTw7Mzu7s%2FlPqYIGLEqjYzIaUhKAFiaT%2BhCTXfoSTsg8GcyQl6pii9rlegPf%0ANaALfKNG1n7EpLaaGY4SmeYlIHOCbRdvKzYeUlZZ44wwigyCjrd8jkl2lAVA%0AXnjV8qDUUXGQ3Jd8z49fulKFygwvix6Gj4t7L9ajgVjDUqPj2nkYpZOQ3ofj%0Ah5RO2GjKxtPP7r712fmj1KdAbo25P4GQvabpOtxAJi0I10vcyAzsu2eJycoI%0ArlKfaTd4gQjW%2BQmfjMa6BLsF20gBu80qJrlzFYsi9UeRG3TsjlIaYRVxgX1h%0ArDmibLywszWQpEW1G2ZtUPZqtbdH5hdnJOn0MYuuWP0VRf%2FPKBn8Ag%3D%3D%0A"
      unescaped_encoded_xml = CGI.unescape(encoded_xml)
      assert_equal xml, subject.decode(unescaped_encoded_xml, :skip_unescape => true)
    end
    context 'message_url' do
      context 'with not an actual Protocol::Message' do
        [nil, 'text', RSAML::Audience.new('foo')].each do |message|
          should "raise ArgumentError with #{message.class}" do
            assert_raises ArgumentError do
              subject.message_url(message, 'http://example.com')
            end
          end
        end
      end

      context 'with request message' do
        setup do
          @message = RSAML::Protocol::AuthnRequest.new
        end
        should "construct proper redirect url from acs_url without path or query" do
          acs_url = 'http://sp.example.com'
          assert_equal "http://sp.example.com?SAMLRequest=#{subject.message_data(@message)}",
                       subject.message_url(@message, acs_url)
        end
        should "construct proper redirect url from acs_url with path and no existing query" do
          acs_url = 'http://sp.example.com/saml'
          assert_equal "http://sp.example.com/saml?SAMLRequest=#{subject.message_data(@message)}",
                       subject.message_url(@message, acs_url)
        end
        should "construct proper redirect url from acs_url with path and query" do
          acs_url = 'http://sp.example.com/saml?foo=bar'
          assert_equal "http://sp.example.com/saml?foo=bar&SAMLRequest=#{subject.message_data(@message)}",
                       subject.message_url(@message, acs_url)
        end
      end

      context 'with response message' do
        setup do
          @message = RSAML::Protocol::Response.new(RSAML::Protocol::Status.new(RSAML::Protocol::StatusCode.new(:success)))
        end
        should "construct proper redirect url from acs_url without path or query" do
          acs_url = 'http://sp.example.com'
          assert_equal "http://sp.example.com?SAMLResponse=#{subject.message_data(@message)}",
                       subject.message_url(@message, acs_url)
        end
        should "construct proper redirect url from acs_url with path and no existing query" do
          acs_url = 'http://sp.example.com/saml'
          assert_equal "http://sp.example.com/saml?SAMLResponse=#{subject.message_data(@message)}",
                       subject.message_url(@message, acs_url)
        end
        should "construct proper redirect url from acs_url with path and query" do
          acs_url = 'http://sp.example.com/saml?foo=bar'
          assert_equal "http://sp.example.com/saml?foo=bar&SAMLResponse=#{subject.message_data(@message)}",
                       subject.message_url(@message, acs_url)
        end
      end
    end
  end
end
