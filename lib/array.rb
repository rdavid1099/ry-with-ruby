module Ry
  class Array
    def initialize(count = 0, initial_data = 'nil')
      @content = count > 0 ? initialize_array(count, initial_data) : '[]'
    end

    def initialize_array(count, initial_data, i = 0, result = '[')
      while i < count
        result += i == count - 1 ? "#{initial_data}]" : "#{initial_data}, "
        i += 1
      end
      result
    end

    def [](index)
      
    end

    def inspect
      @content
    end
  end
end
