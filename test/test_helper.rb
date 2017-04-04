require 'minitest/autorun'
require 'minitest/pride'
require './config/setup'
require 'pry'

class TestHelper < Minitest::Test
  def new_array(**data)
    data[:count] ||= 0
    @array = Ry::Array.new(data[:count], data[:initial_data])
  end

  def new_node(**data)
    @node = Ry::Node.new(data[:data], data[:prev], data[:next])
  end
end
