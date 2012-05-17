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
  end
end
