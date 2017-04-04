module Ry
  class Node
    def initialize(data, prev = nil, next_node = nil)
      @data = data
      @next = next_node
      @prev = prev
    end

    def data
      @data
    end

    def prev
      @prev
    end

    def next
      @next
    end

    def prev=(node)
      @prev = node
    end

    def next=(node)
      @next = node
    end
  end
end
