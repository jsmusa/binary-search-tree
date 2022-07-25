class Tree
  def initialize(array)
    @array = array
    @root = nil
  end

  def build_tree
    
  end
end

class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data, left_node, right_node)
    @data = data
    @left = left_node
    @right = right_node
  end
end