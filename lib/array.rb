require './config/setup'
module Ry
  class Array
    def initialize(size = 0, initial_data = nil)
      size > 0 ? initialize_array(size, initial_data) : '[]'
    end

    def each(&block)
      current_node = @initial
      while current_node
        block.call(current_node.data)
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

    alias << push

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

    def shift
      return nil unless @initial
      data = @initial.data
      next_node = @initial.next
      @initial.clear!
      @initial = next_node
      data
    end

    def unshift(*args)
      @initial ||= Ry::Node.new(args.pop)
      args.reverse.each do |data|
        unshifted_node = Ry::Node.new(data, nil, @initial)
        @initial.prev = unshifted_node
        @initial = unshifted_node
      end
      self
    end

    def combination(size)
      return Enumerator.new { |y| y } if size > count
      index = 0
      i = 0
      a = Enumerator.new do |y|
        combo_size(size).times do |index|
          data = []
          initial_data = self.[](index)
          size.times do |i|
            data << self.[](index + i)
          end
          y << data
        end
      end
    end

    def compact
      return self unless @initial
      result = Ry::Array.new
      node = @initial
      loop do
        result << node.data unless node.data.nil?
        return result unless node.next
        node = node.next
      end
    end

    def compact!
      return self unless @initial
      result = Ry::Array.new
      node = @initial
      loop do
        result << node.data unless node.data.nil?
        break unless node.next
        node = node.next
      end
      self.replace(result)
    end

    def [](index)
      return nil if index >= count
      node = get_node(index)
      node.data
    end

    alias at []

    def first() self.[](0) end
    def last() count.zero? ? nil : self.[](count - 1) end

    def []=(index, data)
      if index > count
        fill_out_indices(index, data)
      else
        node = get_node(index) || @initial = Ry::Node.new
        node.data = data
      end
      self
    end

    def clear
      while @initial
        next_node = @initial.next
        @initial.clear!
        @initial = next_node
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

    alias length count

    def inspect
      "[#{all_string}]"
    end

    def replace(new_data)
      self.clear
      new_data.each do |data|
        self << data
      end
      self
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

      def combo(size, index)
        data = []
        initial = '@initial' + ('.next' * index)
        (count - (size - 1)).times do |i|
          data << eval(initial + ('.next' * i) + '.data')
        end
        data
      end

      def combo_size(size)
        a = (1..count).inject(:*) || 1
        b = (1..size).inject(:*) || 1
        c = (1..(count - size)).inject(:*) || 1
        a / (b * c)
      end
  end
end
