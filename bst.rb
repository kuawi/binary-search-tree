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

  def level_order
    queue = Queue.new
    queue.enq @root
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
end
