require_relative 'test_helper'

class RyArrayTest < TestHelper
  def test_array_can_be_initialized_without_any_initial_values
    new_array
    assert_instance_of Ry::Array, @array
  end

  def test_array_can_be_initialized_with_number_of_cells_default_to_nil
    new_array(count: 3)
    3.times { |i| assert_nil @array[i] }
  end
  # ::[]
  # ::new
  # ::try_convert
  #&
  #*
  #+
  #-
  #<<
  #<=>
  #==
  #[]
  #[]=
  #abbrev
  #assoc
  #at
  #bsearch
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
