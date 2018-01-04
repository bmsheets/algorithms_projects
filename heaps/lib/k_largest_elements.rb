require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new { |el1, el2| -1 * (el1 <=> el2) }
  array.each { |el| heap.push(el) }
  result = []
  k.times do |i|
    result.push(heap.extract)
  end
  result
end
