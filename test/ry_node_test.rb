require_relative 'test_helper'

class RyArrayTest < TestHelper
  def test_node_is_initialized_with_data
    new_node(data: 4)

    assert_equal 4, @node.data
    assert_nil @node.next
    assert_nil @node.prev
  end

  def test_node_is_initialized_with_data_and_prev_node
    prev = new_node(data: 4)
    new_node(data: 5, prev: prev)

    assert_equal 5, @node.data
    assert_equal prev.data, @node.prev.data
  end

  def test_node_can_have_data_and_prev_and_next
    next_node = new_node(data: 8)
    prev = new_node(data: 5)
    new_node(data: 4, prev: prev)
    @node.next = next_node

    assert_equal 4, @node.data
    assert_equal prev.data, @node.prev.data
    assert_equal next_node.data, @node.next.data
  end
end
