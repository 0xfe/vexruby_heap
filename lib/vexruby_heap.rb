module Vex

=begin
Implementation of ruby binary-heap / priority queue.
Author: Mohit Cheppudira <mohit@muthanna.com>

Classes:
  MaxHeap - Keeps largest value on top of heap.
  MinHeap - Keeps smallest value on top of heap.
  Heap - Allows you to customize the comparator.

Usage:
  h = Vex::MaxHeap.new

  h.empty?  # returns true

  h.insert(10)
  h.insert(20)
  h.insert(15)

  h.peek  # returns 20
  h.remove  # returns 20
  h.peek  # returns 15

  h.size  # returns 2

You can customize the heap by passing in a custom comparator to Heap.

  my_min_heap = Vex::Heap.new(proc {|a, b| b < a})

In fact, this is how MaxHeap and MinHeap are implemented.
=end

class Heap
  attr_reader :data

  def initialize(comparator=nil)
    @data = []

    if comparator.nil?
      @comparator = proc { |a, b| a < b }
    else
      @comparator = comparator
    end
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

  def compare(a, b)
    return @comparator.call(a, b)
  end

  def insert(item)
    @data << item
    pos = @data.length - 1
    while pos != 0
      parent = ((pos + 1) / 2).floor - 1

      if compare(@data[parent], @data[pos])
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
        next_child = right unless compare(@data[right], @data[left])
      end

      if not compare(@data[next_child], @data[pos]) then
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

class MaxHeap < Heap
  def initialize
    super
  end
end

class MinHeap < Heap
  def initialize
    super(proc { |a, b| b < a })
  end
end

end
