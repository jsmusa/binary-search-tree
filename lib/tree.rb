# frozen_string_literal: true

class Tree
  attr :root

  def initialize(array)
    @array = array.sort.uniq
    @root = nil
  end

  def get_root(start_index, end_index, array)
    return if start_index > end_index

    mid = (start_index + end_index) / 2
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

  def insert(value, node = @root)
    return Node.new(value) unless node

    if node > value
      node.left = insert(value, node.left)
    else
      node.right = insert(value, node.right)
    end

    node
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

      node = array.shift
      return_values.push(node.data)

      array.unshift(node.left, node.right).compact!
    end

    return_values
  end

  def inorder(node = @root, array = [], &block)
    return unless node

    inorder(node.left, array, &block)

    # visiting the node
    block.call node if block_given?
    array.push(node.data)

    inorder(node.right, array, &block)

    array
  end

  def postorder(node = @root, array = [], &block)
    return unless node

    postorder(node.left, array, &block)
    postorder(node.right, array, &block)

    block.call node if block_given?
    array.push(node.data)

    array
  end

  def find(value)
    inorder { |node| return node if node == value}
  end

  def next_largest(node)
    node = node.right

    node = node.left while node.left

    node
  end

  def delete(value, node = @root)
    return unless node

    node.left = delete(value, node.left)
    node.right = delete(value, node.right)

    if node == value
      return nil if !node.left && !node.right

      if node.left && node.right
        # replacement for deleted node
        larger = next_largest(node)

        delete(larger.data)

        node.data = larger.data

        return node
      end

      return node.left || node.right
    end

    node
  end

  def height(node)
    return 0 unless node

    left = height(node.left)
    right = height(node.right)

    left += 1
    right += 1

    [left, right].max
  end

  def depth(node)
    height(@root) - height(node)
  end

  def balanced?(node = @root)
    condition = height(node.left) - height(node.right)
    return false if condition.abs > 1

    true
  end

  def rebalance
    array = inorder.uniq
    build_tree(array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
