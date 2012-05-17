require File.dirname(__FILE__) + '/../test_helper'

class BaseTest < Test::Unit::TestCase
  include RSAML::Binding
  context "Binding::Base" do
    subject { Base }
    context "encode" do
      should "return same string" do
        assert_equal "XML", subject.encode('XML')
      end
    end
    context "decode" do
      should "return same string" do
        assert_equal "XML", subject.decode('XML')
      end
    end
  end
end
