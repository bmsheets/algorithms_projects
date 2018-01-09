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
  result = []
  nodes = vertices.map {|vertex| [vertex, 0]}
  unmarked = nodes.select {|node| node[1] == 0}
  while unmarked.length > 0
    visit(unmarked.first, result)
    unmarked = nodes.select {|node| node[1] == 0}
  end
end

def visit(node, arr)
  return if node[1] == 2
  return if node[1] == 1
  node[0].out_edges.each do |edge|
    visit(edge.to_vertex, arr)
  end
  node[1] = 1
  node[1] = 2
  result.unshift(node[0])
end
