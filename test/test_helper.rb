require 'rubygems'
require 'minitest/autorun'
require 'shoulda'

require File.dirname(__FILE__) + '/../lib/rsaml'
include RSAML
include RSAML::Statement

class MiniTest::Test
  def date_match
    '\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z'
  end
  def uuid_match
    '_[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}'
  end

  def assert_nothing_raised
    yield
  end
end
