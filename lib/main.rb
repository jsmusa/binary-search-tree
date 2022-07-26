require_relative "tree"
require_relative "node"

array = Array.new(15) {rand(1..100)}

tree = Tree.new(array)

def print_data(tree)
  tree.preorder {|node| puts node.data}
  puts
  tree.inorder {|node| puts node.data}
  puts
  tree.postorder {|node| puts node.data}
  puts
end


tree.build_tree

puts tree.pretty_print

return unless tree.balanced?

print_data(tree)

15.times do
  tree.insert(rand(100..1000))
end

return if tree.balanced?

tree.rebalance

print_data(tree)

puts tree.pretty_print
