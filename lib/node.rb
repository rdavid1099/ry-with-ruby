module Ry
  class Node
    attr_accessor :data, :next, :prev
    def initialize(data, prev = nil, next_node = nil)
      @data = data
      @next = next_node
      @prev = prev
    end
  end
end
