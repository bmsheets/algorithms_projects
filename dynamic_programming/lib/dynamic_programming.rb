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
    table = knapsack_table(weights, values, capacity)
    table[capacity].last
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    table = [Array.new(values.length) {0}]
    (1..capacity).each do |capacity|
      prev = 0
      best = []
      values.length.times do |i|
        value = values[i]
        weight = weights[i]
        if i == 0 && weight <= capacity
          take = value
        else
          take = value + table[capacity - weight][i - 1] if capacity - weight >= 0
        end
        if take && take > prev
          best[i] = take
        else
          best[i] = prev
        end
        prev = best[i]
      end
      table.push(best)
    end
    table
  end

  def maze_solver(maze, start_pos, end_pos)
  end

  def valid_moves(maze, pos)
    width = maze.first.length
    height = maze.length
    moves = []
    [-1, 1].each do |i|
      [-1, 1].each do |j|
        x = pos[0] + i
        y = pos[1] + j
        if x.between?(0, width-1) && y.between?(0, height-1) && maze[y][x] != 'X'
          moves.push([x, y])
        end
      end
    end
    moves
  end
end
