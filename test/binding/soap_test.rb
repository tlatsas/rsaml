require File.dirname(__FILE__) + '/../test_helper'

class SOAPTest < Test::Unit::TestCase
  include RSAML::Binding

  context 'RSAML::Binding::SOAP' do
    subject { RSAML::Binding::SOAP }
    should 'have identification set to "urn:oasis:names:tc:SAML:2.0:bindings:SOAP"' do
      assert_equal 'urn:oasis:names:tc:SAML:2.0:bindings:SOAP', subject.identification
    end
  end
end
