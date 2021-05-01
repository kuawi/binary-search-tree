require_relative 'bst'

array = Array.new(15) { rand(1..100) }
my_tree = Tree.new(array)

puts "Balanced: #{my_tree.balanced?}"
p my_tree.level_order
p my_tree.preorder
p my_tree.inorder
p my_tree.postorder
puts 'Creating imbalance...'
rand(2..5).times { my_tree.insert(rand(101..200)) }
puts "Balanced: #{my_tree.balanced?}"
puts 'Rebalancing...'
my_tree.rebalance
puts "Balanced: #{my_tree.balanced?}"
p my_tree.level_order
p my_tree.preorder
p my_tree.inorder
p my_tree.postorder
