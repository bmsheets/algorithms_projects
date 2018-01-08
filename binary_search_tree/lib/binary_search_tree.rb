# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    @root = BSTNode.new(value) unless @root
    if value < @root.value
      if @root.left
        left_tree.insert(value)
      else
        @root.left = BSTNode.new(value, @root)
      end
    elsif value > @root.value
      if @root.right
        right_tree.insert(value)
      else
        @root.right = BSTNode.new(value, @root)
      end
    end
  end

  def find(value, tree_node = @root)
    return tree_node if tree_node.value == value
    if value < tree_node.value
      if tree_node.left
        find(value, tree_node.left)
      else
        return nil
      end
    else
      if tree_node.right
        find(value, tree_node.right)
      else
        return nil
      end
    end
  end

  def delete(value)
    node = find(value)
    return nil unless node
    if node.left && node.right
      max = maximum(node.left)
      node.value = max.value
      max.parent.right = max.left ? max.left : nil
    elsif node.left || node.right
      if node.left
        node.value = node.left.value
        node.left = nil
      else
        node.value = node.right.value
        node.right = nil
      end
    else
      if node == @root
        @root = nil
      elsif node.parent.left == node
        node.parent.left = nil
      elsif node.parent.right == node
        node.parent.right = nil
      else
        raise "invalid bst structure"
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    node = tree_node
    while node.right
      node = node.right
    end
    node
  end

  def depth(tree_node = @root)
    return 0 unless tree_node && (tree_node.left || tree_node.right)
    return 1 + [depth(tree_node.left), depth(tree_node.right)].max
  end

  def is_balanced?(tree_node = @root)
    result = (depth(tree_node.left) - depth(tree_node.right)).abs < 2
    result = result && is_balanced?(tree_node.left) if tree_node.left
    result = result && is_balanced?(tree_node.right) if tree_node.right
    result
  end

  def in_order_traversal(tree_node = @root, arr = [])
    if tree_node.left
      in_order_traversal(tree_node.left, arr)
    end
    arr.push(tree_node.value)
    if tree_node.right
      in_order_traversal(tree_node.right, arr)
    end
    arr
  end


  private
  # optional helper methods go here:
  def left_tree
    tree = BinarySearchTree.new
    tree.root = @root.left
    tree
  end

  def right_tree
    tree = BinarySearchTree.new
    tree.root = @root.right
    tree
  end

end
