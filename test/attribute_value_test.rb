require File.dirname(__FILE__) + '/test_helper'

class AttributeValueTest < MiniTest::Test
  context "an attribute value" do
    setup do
      @attribute_value = AttributeValue.new('foo')
    end
    context "when producing xml" do
      should "always include xml schema namespaces and xs:string type" do
        assert_equal '<saml:AttributeValue xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="xs:string">foo</saml:AttributeValue>', @attribute_value.to_xml
      end
    end
  end
end
