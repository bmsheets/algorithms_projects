class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next if @prev
    @next.prev = @prev if @next
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList
  attr_reader :length

  include Enumerable

  def initialize
    @head = nil
    @tail = nil
    @length = 0
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @length == 0
  end

  def get(key)
    node = @head
    while (node)
        return node.val if node.key == key
        node = node.next
    end
    nil
  end

  def include?(key)
    node = @head
    while (node)
        return true if node.key == key
        node = node.next
    end 
    false
  end

  def append(key, val)
    node = Node.new(key, val)
    if empty?
        @head = node
        @tail = node
    else
        node.prev = @tail
        @tail.next = node
        @tail = node
    end
    @length += 1
  end

  def update(key, val)
    node = @head
    while(node)
        node.val = val if node.key == key
        node = node.next
    end
  end

  def remove(key)
    node = @head
    while(node)
        if node.key == key 
            if node == @head
                @head.next.prev = nil
                @head = @head.next
            elsif node == @tail
                @tail.prev.next = nil
                @tail = @tail.prev
            else
                node.prev.next = node.next
                node.next.prev = node.prev
            end
            @length -= 1
        end
        node = node.next
    end
  end

  def each(&block)
    node = @head
    while(node)
        block.call(node)
        node = node.next
    end 
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end
