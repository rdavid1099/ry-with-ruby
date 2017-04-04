require './config/setup'
module Ry
  class Array
    def initialize(size = 0, initial_data = nil)
      size > 0 ? initialize_array(size, initial_data) : '[]'
    end

    def initialize_array(size, initial_data)
      size.times { @initial ? push(initial_data) : (@initial = Ry::Node.new(initial_data)) }
    end

    def push(data)
      unless @initial
        @initial = Ry::Node.new(data)
      else
        last_node = get_node
        last_node.next = Ry::Node.new(data, last_node)
      end
      eval(inspect)
    end

    def [](index)
      return nil if index >= count
      node = get_node(index)
      node.data
    end

    def []=(index, data)
      if index >= count
        fill_out_indices(index, data)
      else
        node = get_node(index)
        node.data = data
      end
      eval(inspect)
    end

    def inspect
      "[#{all_string}]"
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

    private
      def fill_out_indices(index, data)
        last_node = get_node
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
          result += "#{sanitize(current_node.data)}, "
          return result.chomp(', ') if current_node.next.nil?
          current_node = current_node.next
        end
      end

      def sanitize(data)
        if data.nil?
          'nil'
        elsif data.is_a? String
          "\"#{data}\""
        else
          data
        end
      end
  end
end
