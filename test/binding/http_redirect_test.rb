require File.dirname(__FILE__) + '/../test_helper'

class HTTPRedirectTest < Test::Unit::TestCase
  include RSAML::Binding

  context 'RSAML::Binding::HTTPRedirect' do
    subject { RSAML::Binding::HTTPRedirect }
    should 'have identification set to "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"' do
      assert_equal 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect', subject.identification
    end
    should 'encode according to the spec' do
      assert_equal 'eJwLcY0IiXdxDHEEAA4cAr8=%0A', subject.encode('TEXT_DATA')
    end
    should 'decode according to the spec' do
      assert_equal 'TEXT_DATA', subject.decode('eJwLcY0IiXdxDHEEAA4cAr8=%0A')
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
