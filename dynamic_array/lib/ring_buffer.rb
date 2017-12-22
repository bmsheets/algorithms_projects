require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(@start_idx + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(@start_idx + index) % @capacity] = val
  end

  # O(1)
  def pop
    raise("index out of bounds") if @length == 0
    result = @store[(@start_idx + @length  - 1) % @capacity]
    @store[(@start_idx + @length  - 1) % @capacity] = nil
    @length -= 1
    result
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[(@start_idx + @length) % @capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    raise("index out of bounds") if @length == 0
    result = @store[@start_idx]
    @store[@start_idx] = nil
    @start_idx = (@start_idx + 1) % capacity
    @length -= 1
    result
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise("index out of bounds") if index < 0 || index >= @length
  end

  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    @length.times do |i|
      index = (@start_idx + i) % @length
      new_store[i] = @store[index]
    end
    @store = new_store
    @start_idx = 0
  end
end
