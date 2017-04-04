require_relative 'test_helper'

class RyArrayTest < TestHelper
  def test_array_can_be_initialized_without_any_initial_values
    new_array
    assert_instance_of Ry::Array, @array
  end

  def test_array_can_be_initialized_with_number_of_cells_default_to_nil
    new_array(count: 3)
    assert_equal 3, @array.count
    3.times { |i| assert_nil @array[i] }
  end

  def test_array_can_be_initialized_with_number_of_cells_default_to_data
    new_array(count: 3, initial_data: 4)
    assert_equal 3, @array.count
    3.times { |i| assert_equal 4, @array[i] }
  end

  def test_array_at_index_can_be_replaced
    new_array(count: 3, initial_data: 4)
    @array[0] = 5
    @array[2] = 8

    assert_equal 5, @array[0]
    assert_equal 4, @array[1]
    assert_equal 8, @array[2]
    assert_nil @array[8]
  end

  def test_array_creates_nil_indices_if_indicated
    new_array(count: 3, initial_data: 4)
    @array[0] = 5
    @array[2] = 8
    @array[8] = 'test'

    assert_equal 5, @array[0]
    assert_equal 4, @array[1]
    assert_equal 8, @array[2]
    assert_nil @array[3]
    assert_nil @array[4]
    assert_nil @array[5]
    assert_nil @array[6]
    assert_nil @array[7]
    assert_equal 'test', @array[8]
    assert_equal 9, @array.count
  end

  #[]=
  #abbrev
  #assoc
  #at
  #clear
  #collect
  #collect!
  #combination
  #compact
  #compact!
  #concat
  #count
  #cycle
  #dclone
  #delete
  #delete_at
  #delete_if
  #drop
  #drop_while
  #each
  #each_index
  #empty?
  #eql?
  #fetch
  #fill
  #find_index
  #first
  #flatten
  #flatten!
  #frozen?
  #hash
  #include?
  #index
  #initialize_copy
  #insert
  #inspect
  #join
  #keep_if
  #last
  #length
  #map
  #map!
  #pack
  #permutation
  #pop
  #pretty_print
  #pretty_print_cycle
  #product
  #push
  #rassoc
  #reject
  #reject!
  #repeated_combination
  #repeated_permutation
  #replace
  #reverse
  #reverse!
  #reverse_each
  #rindex
  #rotate
  #rotate!
  #sample
  #select
  #select!
  #shelljoin
  #shift
  #shuffle
  #shuffle!
  #size
  #slice
  #slice!
  #sort
  #sort!
  #sort_by!
  #take
  #take_while
  #to_a
  #to_ary
  #to_s
  #transpose
  #uniq
  #uniq!
  #unshift
  #values_at
  #zip
  #|
end
