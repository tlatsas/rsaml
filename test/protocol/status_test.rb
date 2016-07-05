require File.dirname(__FILE__) + '/../test_helper'

class StatusTest < MiniTest::Test
  include RSAML::Protocol
  
  context "a status instance" do
    setup do
      @status = Status.new(StatusCode.new(:success))
    end
    context "when producing xml" do
      should "include a status code" do
        assert_match(%Q(<samlp:StatusCode Value="#{StatusCode::Values::SUCCESS}">), @status.to_xml)
      end
    end
  end
end
