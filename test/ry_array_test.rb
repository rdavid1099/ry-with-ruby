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

  def test_array_can_be_popped
    new_array
    3.times { |i| @array.push(i) }

    assert_equal 2, @array.pop
    assert_equal 2, @array.count
    assert_equal 1, @array.pop
    assert_equal 1, @array.count
    assert_equal 0, @array.pop
    assert_equal 0, @array.count
    assert_nil @array.pop
  end

  def test_array_can_be_shifted
    new_array
    3.times { |i| @array.push(i) }

    assert_equal 0, @array.shift
    assert_equal 1, @array.first
    assert_equal 2, @array.count
    assert_equal 1, @array.shift
    assert_equal 2, @array.first
    assert_equal 1, @array.count
    assert_equal 2, @array.shift
    assert_equal 0, @array.count
    assert_nil @array.shift
  end

  def test_array_can_be_unshifted
    new_array
    3.times { |i| @array.unshift(i) }

    assert_equal 2, @array[0]
    assert_equal 1, @array[1]
    assert_equal 0, @array[2]

    @array.unshift('a', 'b')

    assert_equal 'a', @array[0]
    assert_equal 'b', @array[1]
    assert_equal 2, @array[2]
  end

  def test_array_can_be_cleared
    new_array(count: 3, initial_data: 4)
    @array.clear

    assert_equal 0, @array.count
    assert_equal @array, @array.clear
  end

  def test_iterating_array_using_each
    new_array(count: 3, initial_data: 4)
    result = 0
    return_array = @array.each do |data|
      result += data
    end

    assert_equal 12, result
    assert_equal return_array, @array
  end

  def test_iterating_array_using_each_with_index
    new_array(count: 4, initial_data: 4)
    result = 0
    return_array = @array.each_with_index do |data, index|
      result += (data * index)
    end

    assert_equal 24, result
    assert_equal return_array, @array
  end

  def test_iterating_array_using_map
    new_array(count: 4, initial_data: 4)
    counter = 0
    return_array = @array.map do |data|
      result = if counter == 0
                'hello'
              elsif counter == 1
                'world'
              elsif counter == 2
                data * 2
              else
                data
              end
      counter += 1
      result
    end

    @array.each { |data| assert_equal 4, data }
    assert_equal 'hello', return_array[0]
    assert_equal 'world', return_array[1]
    assert_equal 8, return_array[2]
    assert_equal 4, return_array[3]
  end

  def test_iterating_array_using_map!
    new_array(count: 4, initial_data: 4)
    counter = 0
    return_array = @array.map! do |data|
      result = if counter == 0
                'hello'
              elsif counter == 1
                'world'
              elsif counter == 2
                data * 2
              else
                data
              end
      counter += 1
      result
    end

    return_array.each_with_index { |data, i| assert_equal data, @array[i] }
  end

  def test_iterating_array_using_collect
    new_array(count: 4, initial_data: 4)
    counter = 0
    return_array = @array.collect do |data|
      result = if counter == 0
                'hello'
              elsif counter == 1
                'world'
              elsif counter == 2
                data * 2
              else
                data
              end
      counter += 1
      result
    end

    @array.each { |data| assert_equal 4, data }
    assert_equal 'hello', return_array[0]
    assert_equal 'world', return_array[1]
    assert_equal 8, return_array[2]
    assert_equal 4, return_array[3]
  end

  def test_iterating_array_using_collect!
    new_array(count: 4, initial_data: 4)
    counter = 0
    return_array = @array.collect! do |data|
      result = if counter == 0
                'hello'
              elsif counter == 1
                'world'
              elsif counter == 2
                data * 2
              else
                data
              end
      counter += 1
      result
    end

    return_array.each_with_index { |data, i| assert_equal data, @array[i] }
  end

  def test_iterating_array_using_reduce
    new_array(count: 4, initial_data: 4)
    sum = @array.reduce(0) do |result, data|
      result += data
    end
    assert_equal 16, sum

    difference = @array.reduce(0) do |result, data|
      result -= data
    end
    assert_equal -16, difference

    string = @array.reduce("") do |result, data|
      result += data.to_s
    end
    assert_equal '4444', string

    ry_array = @array.reduce(Ry::Array.new) do |result, data|
      result.push(data)
    end
    ry_array.each { |data| assert_equal 4, data }

    @array.each { |data| assert_equal 4, data }
  end

  def test_iterating_array_using_inject
    new_array(count: 4, initial_data: 4)
    sum = @array.inject(0) do |result, data|
      result += data
    end
    assert_equal 16, sum

    difference = @array.inject(0) do |result, data|
      result -= data
    end
    assert_equal -16, difference

    string = @array.inject("") do |result, data|
      result += data.to_s
    end
    assert_equal '4444', string

    ry_array = @array.inject(Ry::Array.new) do |result, data|
      result.push(data)
    end
    ry_array.each { |data| assert_equal 4, data }

    @array.each { |data| assert_equal 4, data }
  end

  def test_array_combination
    skip
    new_array
    4.times { |i| @array << (i + 1)}
    combo_one = @array.combination(1)
    combo_two = @array.combination(2)
    combo_three = @array.combination(3)
    combo_four = @array.combination(4)
    combo_zero = @array.combination(0)
    combo_five = @array.combination(5)

    assert_equal [[1],[2],[3],[4]], combo_one.to_a
    assert_equal [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]], combo_two.to_a
    assert_equal [[1,2,3],[1,2,4],[1,3,4],[2,3,4]], combo_three.to_a
    assert_equal [[1,2,3,4]], combo_four.to_a
    assert_equal [[]], combo_zero.to_a
    assert_equal [], combo_five.to_a
  end

  def test_array_compact
    new_array
    4.times { |i| @array << (i.even? ? (i + 1) : nil)}

    assert_equal 2, @array.compact.count
    assert_equal 1, @array.compact.first
    assert_equal 3, @array.compact.last
  end

  def test_array_compact!
    new_array
    4.times { |i| @array << (i.even? ? (i + 1) : nil)}
    @array.compact!

    assert_equal 2, @array.count
    assert_equal 1, @array.first
    assert_equal 3, @array.last
  end

  #concat
  #cycle
  #dclone
  #delete
  #delete_at
  #delete_if
  #drop
  #drop_while
  #empty?
  #eql?
  #fetch
  #fill
  #find_index
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
  #pack
  #permutation
  #pretty_print
  #pretty_print_cycle
  #product
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
  #values_at
  #zip
end
