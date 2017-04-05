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

  #assoc
  #at
  #clear
  #combination
  #compact
  #compact!
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
  #pack
  #permutation
  #pop
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
end
