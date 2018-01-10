class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    @blair_cache[n] = blair_nums(n - 1) + blair_nums(n - 2) + nth_odd(n - 1)
  end

  def nth_odd(n)
    2 * n - 1
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }
    return cache if n < 4
    (4..n).each do |i|
      result = []
      prev1 = cache[i - 1]
      prev2 = cache[i - 2]
      prev3 = cache[i - 3]

      [prev1, prev2, prev3].each_with_index do |prev, idx|
        prev.each do |pattern1|
          cache[idx + 1].each do |pattern2|
            result.push(pattern1 + pattern2)
          end
        end
      end

      cache[i] = result.uniq
    end
    cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if n < 4
    prev1 = frog_hops_top_down_helper(n - 1)
    prev2 = frog_hops_top_down_helper(n - 2)
    prev3 = frog_hops_top_down_helper(n - 3)

    result = []
    [prev1, prev2, prev3].each_with_index do |prev, idx|
      prev.each do |pattern|
        @frog_cache[idx + 1].each do |pattern2|
          result.push(pattern + pattern2)
        end
      end
    end

    @frog_cache[n] = result.uniq
    @frog_cache[n]
  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
