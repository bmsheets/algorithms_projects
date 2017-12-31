require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
        #obj exists in cache
        update_node!(@map[key])
    else
        #obj not found in cache
       calc!(key) 
    end
    if count > @max
        eject!
    end
    return @map[key].val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    @store.append(key, val)
    @map[key] = @store.last 
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    #node.prev.next = node.next if node.prev
    #node.next.prev = node.prev if node.next
    @store.remove(node.key)
    @store.append(node.key, node.val)
    @map[node.key] = @store.last
  end

  def eject!
    key = @store.first.key
    @map.delete(key)
    @store.remove(key)
  end
end
