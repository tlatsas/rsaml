require File.dirname(__FILE__) + '/../test_helper'

class HTTPPostTest < Test::Unit::TestCase
  include RSAML::Binding

  context 'RSAML::Binding::HTTPPost' do
    subject { RSAML::Binding::HTTPPost }
    should 'have identification set to "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"' do
      assert_equal 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST', subject.identification
    end
    should 'encode with base64' do
      assert_equal "VEVYVF9EQVRB\n", subject.encode('TEXT_DATA')
    end
    should 'decode with base64' do
      assert_equal 'TEXT_DATA', subject.decode("VEVYVF9EQVRB\n")
    end
  end
end
