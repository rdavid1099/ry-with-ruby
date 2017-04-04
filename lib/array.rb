require './config/setup'
module Ry
  class Array
    def initialize(size = 0, initial_data = nil)
      size > 0 ? initialize_array(size, initial_data) : '[]'
    end

    def initialize_array(size, initial_data)
      size.times { @initial ? push(initial_data) : (@initial = Node.new(initial_data)) }
    end

    def push(data)
      return @initial = Node.new(data) unless @initial
      last_node = get_last_node
      last_node.next = Node.new(data, last_node)
    end

    def [](index)
      return nil if index >= count
      node = "@initial" + ('.next' * index) + '.data'
      eval(node)
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
      def get_last_node(current_node = @initial)
        loop do
          return current_node if current_node.next.nil?
          current_node = current_node.next
        end
      end

      def all_string
        result = ''
        return '' unless current_node = @initial
        loop do
          result += current_node.next ? "#{current_node.data}, " : current_node.data
          return result if current_node.next.nil?
        end
      end
  end
end

class NilClass
  def to_s
    'nil'
  end
end
