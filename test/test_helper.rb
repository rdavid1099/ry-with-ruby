require 'minitest/autorun'
require 'minitest/pride'
require './config/setup'
require 'pry'

class TestHelper < Minitest::Test
  def setup
    @array = Ry::Array.new
  end
end
