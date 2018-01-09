require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Khan's
def topological_sort(vertices)
  # degrees = {}
  # vertices.each do |vertex|
  #   degrees[vertex] = vertex.in_edges.length
  # end
  #
  # queue = []
  # degrees.select do |key, value|
  #   value == 0
  # end.keys.each do |vertex|
  #   queue.push(vertex)
  # end
  queue = vertices.select {|vertex| vertex.in_edges.length == 0}

  result = []
  until queue.empty?
    u = queue.shift
    neighbors = u.out_edges.map {|edge| edge.to_vertex}
    u.out_edges.each {|edge| edge.destroy!}
    p "adding neighbors: " + neighbors.map {|n| n.value}.to_s
    p "neighbors with zero in-degree: " + neighbors.select {|vertex| vertex.in_edges.length == 0}.map{|n| n.value}.to_s
    queue.concat(neighbors.select {|vertex| vertex.in_edges.length == 0})
    result.push(u)
  end
  return [] unless result.length == vertices.length
  result
end

# Tarian's
def topological_sort2(vertices)

end
