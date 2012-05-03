require File.dirname(__FILE__) + '/../test_helper'

class NameIdPolicyTest < Test::Unit::TestCase
  include RSAML::Protocol
  context "a name id policy instance" do
    setup do
      @name_id_policy = NameIdPolicy.new
    end
    context "#allow_create?" do
      should "be false when allow_create is false" do
        @name_id_policy.allow_create = false
        assert_equal false, @name_id_policy.allow_create?
      end
      should "be false when allow_create is nil" do
        @name_id_policy.allow_create = nil
        assert_equal false, @name_id_policy.allow_create?
      end
      should "be true when allow_create is true" do
        @name_id_policy.allow_create = true
        assert_equal true, @name_id_policy.allow_create?
      end
    end
    context "when producing xml" do
      should "output the samlp:NameIDPolicy element" do
        assert_match '<samlp:NameIDPolicy/>', @name_id_policy.to_xml
      end
      should "optionally include format" do
        @name_id_policy.format = 'urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified'
        assert_match '<samlp:NameIDPolicy Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified"', @name_id_policy.to_xml
      end
      should "optionally include sp_name_qualifier" do
        @name_id_policy.sp_name_qualifier = 'example.com'
        assert_match '<samlp:NameIDPolicy SPNameQualifier="example.com"', @name_id_policy.to_xml
      end
      should "optionally include a allow_create flag" do
        @name_id_policy.allow_create = true
        assert_match '<samlp:NameIDPolicy AllowCreate="true"', @name_id_policy.to_xml
      end
    end
  end
end
