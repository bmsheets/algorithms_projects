require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = []
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise("index out of bounds") if @length == 0
    @length -= 1
    @store.pop
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    @length += 1
    if @length > @capacity
      resize!
    end
    @store.push(val)
  end

  # O(n): has to shift over all the elements.
  def shift
    raise("index out of bounds") if @length == 0
    @length -= 1
    result = @store[0]
    idx = 0
    while idx < @length
      @store[idx] = @store[idx + 1]
      idx += 1
    end
    result
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    @length += 1
    if @length > @capacity
      resize!
    end
    idx = @length - 1
    while idx > 0
      @store[idx] = @store[idx - 1]
      idx -= 1
    end
    @store[0] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise("index out of bounds") unless index >= 0 && index < @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    prev = @store
    @capacity *= 2
    @store = Array.new(@capacity)
    prev.each_with_index do |el, idx|
      @store[idx] = el
    end
  end
end
