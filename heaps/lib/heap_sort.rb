require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new { |el1, el2| -1 * (el1 <=> el2) }
    (self.length - 1).downto(0).each do |idx|
      BinaryMinHeap.heapify_up(self, idx, self.length, &prc)
    end
    puts "heapified array:" + self.to_s
    partition = self.length - 1
    while partition  >= 0
      self[0], self[partition] = self[partition], self[0]
      partition  -= 1
      BinaryMinHeap.heapify_down(self, 0, partition  + 1, &prc)
    end
    self
  end
end
