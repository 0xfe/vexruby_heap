#!/usr/bin/env ruby -w

require 'pp'
require 'test/unit'
require 'vexruby_heap'

class TestHeap < Test::Unit::TestCase
  def test_deterministic
    h = Vex::Heap.new
    assert(h.empty?)
    (1..1000).each { |x| h.insert x; assert(h.peek == x) }
    999.downto(1).each { |x| h.remove; assert(h.peek == x) }
    assert_equal(1, h.size)
  end

  def test_random
    h = Vex::Heap.new
    assert_equal(0, h.size)
    1000.times { h.insert rand(1000); assert(h.peek == h.data.max) }
    1000.times {
      max = h.data.max
      assert(max == h.remove);
      assert(h.peek == h.data.max)
    }
    assert(h.empty?)
    assert(h.remove == nil)
  end
end
