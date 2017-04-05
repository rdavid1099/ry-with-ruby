require './config/setup'
module Ry
  class Array
    def initialize(size = 0, initial_data = nil)
      size > 0 ? initialize_array(size, initial_data) : '[]'
    end

    def each(&block)
      return self unless current_node = @initial
      loop do
        block.call(current_node.data)
        break unless current_node.next
        current_node = current_node.next
      end
      self
    end

    def each_with_index(&block)
      return self unless current_node = @initial
      counter = 0
      loop do
        block.call(current_node.data, counter)
        return self unless current_node.next
        counter += 1
        current_node = current_node.next
      end
    end

    def map(&block)
      return self unless current_node = @initial
      result = Ry::Array.new
      loop do
        result.push(block.call(current_node.data))
        return result unless current_node.next
        current_node = current_node.next
      end
    end

    alias collect map

    def map!(&block)
      return self unless current_node = @initial
      counter = 0
      loop do
        self[counter] = block.call(current_node.data)
        return self unless current_node.next
        counter += 1
        current_node = current_node.next
      end
    end

    alias collect! map!

    def reduce(result, &block)
      return self unless current_node = @initial
      loop do
        result = block.call(result, current_node.data)
        return result unless current_node.next
        current_node = current_node.next
      end
    end

    alias inject reduce

    def push(data)
      unless @initial
        @initial = Ry::Node.new(data)
      else
        last_node = get_node
        last_node.next = Ry::Node.new(data, last_node)
      end
      self
    end

    def pop
      return nil unless @initial
      if second_to_last_node = get_node.prev
        data = second_to_last_node.next.data
        second_to_last_node.next.clear!
      else
        data = @initial.data
        @initial = @initial.clear!
      end
      data
    end

    def [](index)
      return nil if index >= count
      node = get_node(index)
      node.data
    end

    def []=(index, data)
      if index > count
        fill_out_indices(index, data)
      else
        node = get_node(index) || @initial = Ry::Node.new
        node.data = data
      end
      self
    end

    def count
      i = 0
      return i unless current_node = @initial
      loop do
        i += 1
        return i if current_node.next.nil?
        current_node = current_node.next
      end
    end

    def inspect
      "[#{all_string}]"
    end

    private
      def initialize_array(size, initial_data)
        size.times { @initial ? push(initial_data) : (@initial = Ry::Node.new(initial_data)) }
      end

      def fill_out_indices(index, data)
        last_node = count.zero? ? (@initial = Ry::Node.new(nil)) : get_node
        (index - count).times do
          last_node.next = Ry::Node.new(nil, last_node)
          last_node = last_node.next
        end
        last_node.next = Ry::Node.new(data, last_node)
      end

      def get_node(index = nil)
        index ||= count - 1
        eval("@initial" + ('.next' * index))
      end

      def all_string
        result = ''
        return result unless current_node = @initial
        loop do
          result += "#{current_node.data.inspect}, "
          return result.chomp(', ') if current_node.next.nil?
          current_node = current_node.next
        end
      end
  end
end
