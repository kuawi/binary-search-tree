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
end
