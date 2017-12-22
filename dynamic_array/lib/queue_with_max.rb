# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new()
    @max_queue = []
  end

  def enqueue(val)
    @store.push(val)
    while @max_queue.length > 0 && @max_queue.last < val
      @max_queue.pop
    end
    @max_queue.push(val)
  end

  def dequeue
    element = @store.shift
    if @max_queue.first == element
      @max_queue.shift
    end
    element
  end

  def max
    @max_queue.first
  end

  def length
    @store.length
  end

end
