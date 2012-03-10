module Vex

=begin
Implementation of ruby binary-heap / priority queue.
Author: Mohit Cheppudira <mohit@muthanna.com>

Usage:

  h = Vex::Heap.new

  h.empty?  # returns true

  h.insert(10)
  h.insert(20)
  h.insert(15)

  h.peek  # returns 20
  h.remove  # returns 20
  h.peek  # returns 15

  h.size  # returns 2
=end

class Heap
  attr_reader :data

  def initialize
    @data = []
  end

  def empty?
    @data.empty?
  end

  def size
    @data.size
  end

  def peek
    @data.first
  end

  def insert(item)
    @data << item
    pos = @data.length - 1
    while pos != 0
      parent = ((pos + 1) / 2).floor - 1

      if @data[parent] < @data[pos]
        @data[pos], @data[parent] = @data[parent], @data[pos]
        pos = parent
      else
        return
      end
    end
  end

  def remove
    return nil if empty?
    return @data.pop if size == 1

    # Move last value to root
    retval, @data[0] = @data[0], @data.pop

    pos = 0
    while true
      left = ((pos + 1) * 2) - 1
      right = left + 1
      next_child = left

      break if left >= size

      if right < size then
        next_child = right if @data[right] > @data[left]
      end

      if @data[next_child] > @data[pos] then
        @data[next_child], @data[pos] = @data[pos], @data[next_child]
        pos = next_child
      else
        break
      end
    end

    return retval
  end

  alias :pop :remove
  alias :push :insert
end

end
