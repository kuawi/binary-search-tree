require 'pry'
class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    data <=> other.data
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

  def build_tree(array)
    return nil if array.empty?
    return Node.new(array[0]) if array.size == 1

    mid_index = array.size / 2
    data = array[mid_index]
    left_subtree = array[0..(mid_index - 1)]
    right_subtree = array[(mid_index + 1)..-1]

    Node.new(data, build_tree(left_subtree), build_tree(right_subtree))
  end

  def level_order(root = @root)
    queue = Queue.new
    queue.enq root
    level_order_arr = []
    until queue.empty?
      curent_node = queue.deq
      queue.enq curent_node.left if curent_node.left
      queue.enq curent_node.right if curent_node.right
      level_order_arr.push curent_node.data
    end
    level_order_arr
  end

  def preorder(root = @root)
    return [] unless root

    [root.data] + preorder(root.left) + preorder(root.right)
  end

  def inorder(root = @root)
    return [] unless root

    inorder(root.left) + [root.data] + inorder(root.right)
  end

  def postorder(root = @root)
    return [] unless root

    postorder(root.left) + postorder(root.right) + [root.data]
  end

  def find(value)
    node = Node.new(value)
    curent_node = @root
    while curent_node
      break if node == curent_node

      curent_node = node > curent_node ? curent_node.right : curent_node.left
    end
    curent_node
  end

  def depth(node)
    curent_node = @root
    depth = 0
    while curent_node
      break if node == curent_node

      curent_node = node > curent_node ? curent_node.right : curent_node.left
      depth += 1
    end
    return depth if curent_node

    nil
  end

  # height is defined as the number of edges in longest path from a given node to a leaf node.
  def height(node)
    node = find(node.data)
    return nil unless node

    queue = Queue.new.enq(@root)
    until queue.empty?
      curent_node = queue.deq
      queue.enq curent_node.left if curent_node.left
      queue.enq curent_node.right if curent_node.right
    end
    leaf = curent_node
    depth(leaf) - depth(node)
  end

  def to_s
    string = ''
    (0..tree_depth).each do |level|
      string += "#{print_level(@root, level)}\n"
    end
    string
  end

  def delete(value)
    node = Node.new(value)
    curent_node = @root
    while curent_node
      break if node == curent_node

      previous_node = curent_node
      curent_node = node > curent_node ? curent_node.right : curent_node.left
    end
    return unless curent_node

    new_subroot = build_tree(level_order(curent_node)[1..-1].sort.uniq)
    unless new_subroot
      curent_node < previous_node ? previous_node.left = nil : previous_node.right = nil
      return
    end
    new_subroot < previous_node ? previous_node.left = new_subroot : previous_node.right = new_subroot
  end

  private

  def print_level(root, level)
    return nil unless root
    return root.data.to_s if level <= 0

    "#{print_level(root.left, level - 1)} #{print_level(root.right, level - 1)}"
  end

  def tree_depth(root = @root)
    return nil unless root
    return 0 unless root.left || root.right

    left_depth = right_depth = 0
    left_depth += 1 + tree_depth(root.left) if root.left
    right_depth += 1 + tree_depth(root.right) if root.right
    left_depth > right_depth ? left_depth : right_depth
  end
end
