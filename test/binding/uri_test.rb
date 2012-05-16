require File.dirname(__FILE__) + '/../test_helper'

class URITest < Test::Unit::TestCase
  include RSAML::Binding

  context 'RSAML::Binding::URI' do
    subject { RSAML::Binding::URI }
    should 'have identification set to "urn:oasis:names:tc:SAML:2.0:bindings:URI"' do
      assert_equal 'urn:oasis:names:tc:SAML:2.0:bindings:URI', subject.identification
    end
  end
end
