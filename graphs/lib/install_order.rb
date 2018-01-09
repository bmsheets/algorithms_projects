# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require 'topological_sort'

def install_order(arr)
  max_id = arr.max {|tuple| tuple[0]}.first
  vertices = []
  (1..max_id).each do |id|
    vertices.push(Vertex.new(id))
  end
  arr.each do |tuple|
    from_vertex = vertices[tuple[1] - 1]
    to_vertex = vertices[tuple[0] - 1]
    Edge.new(from_vertex, to_vertex)
  end

  result = topological_sort(vertices).map {|vertex| vertex.value}
  result
end
