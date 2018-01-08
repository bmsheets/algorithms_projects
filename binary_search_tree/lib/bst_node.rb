class BSTNode
  attr_accessor :value, :left, :right, :parent

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @left = nil
    @right = nil
  end
end
