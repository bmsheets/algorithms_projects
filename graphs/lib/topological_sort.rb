require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Khan's
def topological_sort(vertices)
  queue = vertices.select {|vertex| vertex.in_edges.length == 0}

  result = []
  until queue.empty?
    u = queue.shift
    neighbors = u.out_edges.map {|edge| edge.to_vertex}
    u.out_edges.each {|edge| edge.destroy!}
    queue.concat(neighbors.select {|vertex| vertex.in_edges.length == 0})
    result.push(u)
  end
  return [] unless result.length == vertices.length
  result
end

# Tarian's
def topological_sort2(vertices)

end
