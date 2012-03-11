#!/usr/bin/env ruby -w

require 'pp'
require 'test/unit'
require 'vexruby_heap'

class TestHeap < Test::Unit::TestCase
  def test_empty
    h = Vex::MaxHeap.new
    assert(h.empty?)
    h.insert 10
    assert(!h.empty?)
    h.remove
    assert(h.empty?)
  end

  def test_size
    h = Vex::MaxHeap.new
    assert(h.size == 0)
    h.insert 10
    assert(h.size == 1)
    h.insert 20
    assert(h.size == 2)
    h.remove
    assert(h.size == 1)
    h.remove
    assert(h.size == 0)
  end

  def test_deterministic
    h = Vex::MaxHeap.new
    (1..1000).each { |x| h.insert x; assert(h.peek == x) }
    999.downto(1) { |x| h.remove; assert(h.peek == x) }
    assert_equal(1, h.size)
  end

  def test_min_heap
    h = Vex::MinHeap.new
    assert(h.empty?)
    1000.downto(1) { |x| h.insert x; assert(h.peek == x) }
    (2..1000).each { |x| h.remove; assert(h.peek == x) }
    assert_equal(1, h.size)
  end

  def test_random
    h = Vex::MaxHeap.new
    assert_equal(0, h.size)

    3000.times do
      h.insert rand(3000)
      assert(h.peek == h.data.max)
    end

    3000.times do
      max = h.data.max
      assert(max == h.remove)
      assert(h.peek == h.data.max)
    end

    assert(h.empty?)
    assert(h.remove == nil)
  end
end
