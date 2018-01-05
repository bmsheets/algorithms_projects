class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array.first
    left, right = [], []
    array[1..-1].each do |el|
      el < pivot ? left.push(el) : right.push(el)
    end
    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    mid = QuickSort.partition(array, start, length, &prc)
    return unless mid
    left_start = start
    left_length = mid - start
    right_start = mid + 1
    right_length = length - mid - 1
    QuickSort.sort2!(array, left_start, left_length, &prc) unless left_start < 0
    QuickSort.sort2!(array, right_start, right_length, &prc) unless right_start >= length
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    return if length <= 1
    pivot = array[start]
    partition = start
    (start + 1...start+length).each do |i|
      if prc.call(pivot, array[i]) > 0
        partition += 1
        array[i], array[partition] = array[partition], array[i]
      end
    end
    array[start], array[partition] = array[partition], array[start]
    partition
  end
end
