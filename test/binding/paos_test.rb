require File.dirname(__FILE__) + '/../test_helper'

class PAOSTest < Test::Unit::TestCase
  include RSAML::Binding

  context 'RSAML::Binding::PAOS' do
    subject { RSAML::Binding::PAOS }
    should 'have identification set to "urn:oasis:names:tc:SAML:2.0:bindings:PAOS"' do
      assert_equal 'urn:oasis:names:tc:SAML:2.0:bindings:PAOS', subject.identification
    end
  end
end
