class Tree
  attr :root
  def initialize(array)
    @array = array.sort.uniq
    @root = nil
  end

  def get_root(start_index, end_index, array)
    return if start_index > end_index

    mid = (start_index + end_index)/2
    root = Node.new(array[mid])
    root.left = get_root(start_index, mid - 1, array)
    root.right = get_root(mid + 1, end_index, array)

    root
  end

  def build_tree(array = @array)
    start_index = 0
    end_index = array.length - 1
    @root = get_root(start_index, end_index, array)
  end

  def insert(value, root = @root)
    return Node.new(value) if !root

    if root > value
      root.left = insert(value, root.left)
    else
      root.right = insert(value, root.right)
    end

    root
  end

  def level_order
    array = [@root]
    return_values = []

    until array.empty?
      # visiting the node
      yield array[0] if block_given?

      # enqueueing root children that are not nil
      array.push(array[0].left, array[0].right).compact!
      
      # dequeueing
      return_values.push(array.shift.data)
    end

    return_values
  end

  def preorder
    array = [@root]
    return_values = []

    until array.empty?
      yield array[0] if block_given?

      root = array.shift
      return_values.push(root.data)

      array.unshift(root.left, root.right).compact!
    end

    return_values
  end

  def inorder(node = @root, array = [])
    return if !node

    inorder(node.left, array) {|node| yield node if block_given?}

    # visiting the node
    yield node if block_given?
    array.push(node.data)

    inorder(node.right, array) {|node| yield node if block_given?}

    array
  end

  def postorder(node = @root, array = [])
    return if !node

    postorder(node.left, array) {|node| yield node}
    postorder(node.right, array) {|node| yield node}

    yield node if block_given?
    array.push(node.data)

    array
  end
  
  def find(value)
    self.level_order {|node| return node if node == value}
  end

  def delete(value)
    # some code
  end

  def height(node)
    return 0 if !node

    left = height(node.left)
    right = height(node.right)

    left += 1
    right += 1

    [left, right].max
  end

  def depth(node)
    height(@root) - height(node)
  end

  def balanced?(root = @root)
    condition = height(root.left) - height(root.right)
    return false if condition.abs > 1

    true
  end

  def rebalance
    array = inorder().uniq
    build_tree(array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

class  Node
  include Comparable

  attr_accessor :data, :left, :right

  def <=>(other)
    if other.is_a?(Node)
      data <=> other.data
    else
      data <=> other
    end
  end

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(array)
tree.build_tree

tree.pretty_print

puts
