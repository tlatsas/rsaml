require File.dirname(__FILE__) + '/../test_helper'

class StatusCodeTest < Test::Unit::TestCase
  include RSAML::Protocol

  context "#initialize" do
    context "with string value" do
      should "set literal value" do
        status_code = StatusCode.new('foo')
        assert_equal 'foo', status_code.value
      end
    end
    context "with symbol value" do
      context "with top level" do
        setup do
          @status_code = StatusCode.new(:success)
        end
        should "set value per the top level mappings" do
          assert_equal StatusCode::Values::SUCCESS, @status_code.value
        end
        should "leave status code nil" do
          assert_nil @status_code.status_code
        end
      end
      context "with second level" do
        setup do
          @status_code = StatusCode.new(:authn_failed)
        end
        should "set value per the top level mappings" do
          assert_equal StatusCode::Values::RESPONDER, @status_code.value
        end
        should "leave status code nil" do
          assert_not_nil @status_code.status_code
          assert_equal StatusCode::Values::AUTHN_FAILED, @status_code.status_code.value
        end
      end
      context "with unknown value" do
        should "raise ArgumentError" do
          assert_raises ArgumentError do
            StatusCode.new :foo
          end
        end
      end
    end
  end

  context "the StatusCode class" do
    should "have 4 top-level status codes" do
      assert_equal 4, StatusCode::TOP_LEVEL_MAPPINGS.length
    end
    should "have 19 second-level status codes" do
      assert_equal 19, StatusCode::SECOND_LEVEL_MAPPINGS.length
    end
    should "have constants for the top-level status codes" do
      assert_equal StatusCode.new(:success).value, StatusCode::Values::SUCCESS
      assert_equal StatusCode.new(:requester).value, StatusCode::Values::REQUESTER
      assert_equal StatusCode.new(:responder).value, StatusCode::Values::RESPONDER
      assert_equal StatusCode.new(:version_mismatch).value, StatusCode::Values::VERSION_MISMATCH
    end
  end

  context "success" do
    setup do
      @status_code = StatusCode.new(:success)
    end
    context "when producing xml" do
      should "have the samlp:StatusCode element name" do
        assert_match(/<samlp:StatusCode/, @status_code.to_xml)
      end
      should "include a value" do
        assert_match(/Value="urn:oasis:names:tc:SAML:2.0:status:Success"/, @status_code.to_xml)
      end
    end
  end
end
