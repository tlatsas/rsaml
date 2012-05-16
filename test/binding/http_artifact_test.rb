require File.dirname(__FILE__) + '/../test_helper'

class HTTPArtifactTest < Test::Unit::TestCase
  include RSAML::Binding

  context 'RSAML::Binding::HTTPArtifact' do
    subject { RSAML::Binding::HTTPArtifact }
    should 'have identification set to "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Artifact"' do
      assert_equal 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Artifact', subject.identification
    end
  end
end
