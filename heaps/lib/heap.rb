class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc
    @prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count - 1] = @store[count - 1], @store[0]
    result = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    result
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, count, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    first = (2 * parent_index) + 1
    second = (2 * parent_index) + 2
    indices = []
    indices.push(first) if first < len
    indices.push(second) if second < len
    indices
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    current_idx = parent_idx
    child_indices = self.child_indices(len, current_idx)
    while child_indices.any? { |idx| prc.call(array[current_idx], array[idx]) > 0 }
      swap_idx = prc.call(array[child_indices.first],array[child_indices.last]) > 0 ?
        child_indices.last : child_indices.first
      array[current_idx], array[swap_idx] = array[swap_idx], array[current_idx]
      current_idx = swap_idx
      child_indices = self.child_indices(len, current_idx)
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    return array if child_idx == 0
    parent_idx = self.parent_index(child_idx)
    while prc.call(array[parent_idx], array[child_idx]) > 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      child_idx = parent_idx
      return array if child_idx == 0
      parent_idx = self.parent_index(child_idx)
    end
    array
  end
end
