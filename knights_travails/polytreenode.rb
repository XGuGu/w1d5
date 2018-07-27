class PolyTreeNode


  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def parent=(node)
    if @parent.is_a?(PolyTreeNode)
      @parent.children.delete(self)
    end

    if node == nil
      @parent = nil
    # elsif
    else
      @parent = node

      if !node.children.include?(self)
        @parent.children << self
      end
    end
  end

  def children
    @children
  end

  def value
    @value
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    node.parent = nil
    raise "no parent!" if node.parent == nil
  end

  def dfs(value)
    # stack = []
    # stack.push(self)
    if self.value == value
      return self
    end

    if self.children.empty? && self.value != value
      return nil
    end



    self.children.each do |child|
      return_val = child.dfs(value)
      if return_val
        return return_val
      end
    end

    nil
  end

  def bfs(value)
    queue = []
    queue.push(self)

    until queue.empty?
      current_child = queue.shift

      current_value = current_child.value
      return current_child if current_value == value

      current_child.children.each do |child|
        queue.push(child)
      end
    end

    nil
  end


end
