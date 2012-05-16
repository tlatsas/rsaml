require File.dirname(__FILE__) + '/../test_helper'

class HTTPRedirectTest < Test::Unit::TestCase
  include RSAML::Binding

  context 'RSAML::Binding::HTTPRedirect' do
    subject { RSAML::Binding::HTTPRedirect }
    should 'have identification set to "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"' do
      assert_equal 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect', subject.identification
    end
  end
end
