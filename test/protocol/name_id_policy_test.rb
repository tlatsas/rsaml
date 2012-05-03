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
  context "from xml" do
    context "with format" do
      setup do
        policy_xml = <<XML
<samlp:NameIDPolicy xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                    Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified"/>
XML
        @name_id_policy = NameIdPolicy.from_xml(policy_xml)
      end
      should "have format set to 'urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified'" do
        assert_equal 'urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified', @name_id_policy.format
      end
      should "have nil sp_name_qualifier" do
        assert_nil @name_id_policy.sp_name_qualifier
      end
      should "have nil allow_create" do
        assert_nil @name_id_policy.allow_create
      end
      should "have allow_create? false" do
        assert_equal false, @name_id_policy.allow_create?
      end
    end
    context "with sp_name_qualifier" do
      setup do
        policy_xml = <<XML
<samlp:NameIDPolicy xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                    SPNameQualifier="example.com"/>
XML
        @name_id_policy = NameIdPolicy.from_xml(policy_xml)
      end
      should "have nil format" do
        assert_nil @name_id_policy.format
      end
      should "have sp_name_qualifier set to 'example.com'" do
        assert_equal 'example.com', @name_id_policy.sp_name_qualifier
      end
      should "have nil allow_create" do
        assert_nil @name_id_policy.allow_create
      end
      should "have allow_create? false" do
        assert_equal false, @name_id_policy.allow_create?
      end
    end
    context "with allow_create true" do
      setup do
        policy_xml = <<XML
<samlp:NameIDPolicy xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                    AllowCreate="true"/>
XML
        @name_id_policy = NameIdPolicy.from_xml(policy_xml)
      end
      should "have nil format" do
        assert_nil @name_id_policy.format
      end
      should "have nil sp_name_qualifier" do
        assert_nil @name_id_policy.sp_name_qualifier
      end
      should "have allow_create set to true" do
        assert_equal true, @name_id_policy.allow_create
      end
      should "have allow_create? false" do
        assert_equal true, @name_id_policy.allow_create?
      end
    end
    context "with all attributes" do
      setup do
        policy_xml = <<XML
<samlp:NameIDPolicy xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                    Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified"
                    SPNameQualifier="example.com"
                    AllowCreate="true"/>
XML
        @name_id_policy = NameIdPolicy.from_xml(policy_xml)
      end
      should "have format set to 'urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified'" do
        assert_equal 'urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified', @name_id_policy.format
      end
      should "have sp_name_qualifier set to 'example.com'" do
        assert_equal 'example.com', @name_id_policy.sp_name_qualifier
      end
      should "have allow_create set to true" do
        assert_equal true, @name_id_policy.allow_create
      end
      should "have allow_create? false" do
        assert_equal true, @name_id_policy.allow_create?
      end
    end
  end
end
