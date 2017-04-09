module Ry
  class Node
    attr_accessor :data, :next, :prev
    def initialize(data = nil, prev = nil, next_node = nil)
      @data = data
      @next = next_node
      @prev = prev
    end

    def clear!
      if @prev && @next
        @prev.next = @next
        @next.prev = @prev
      end
      @prev.next = nil if @prev
      @next.prev = nil if @next
      @data = nil
      @next = nil
      @prev = nil
    end
  end
end
