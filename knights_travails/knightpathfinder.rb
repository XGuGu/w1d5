require_relative "polytreenode"
require"byebug"

class KnightPathFinder
  attr_accessor :visited_positions, :root
  def valid_moves(pos)
    result = []

    x, y = pos

    [[-1, -2], [-2, -1], [-1, 2], [-2, 1], [1, 2], [2, 1], [1, -2], [2, -1]].each do |pair|
      x_pos = x + pair[0]
      y_pos = y + pair[1]

      if x_pos.between?(0, 7) && y_pos.between?(0,7)
        result << [x_pos, y_pos]
      end
    end

    result
  end

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    @root = PolyTreeNode.new(start_pos)
  end

  def new_move_positions(pos)

    all_possible_moves = self.valid_moves(pos)

    new_moves = all_possible_moves.reject { |move| @visited_positions.include?(move) }

    @visited_positions.concat(new_moves)
    new_moves
  end


  def build_move_tree
    queue = []
    queue.push(@root)


    until queue.empty?
      current_node = queue.shift
      current_pos = current_node.value
      new_moves = new_move_positions(current_pos)

      new_moves.each do |new_move|
        new_node = PolyTreeNode.new(new_move)
        new_node.parent = current_node
        queue.push(new_node)
      end
    end
  end

  def find_path(end_pos)
    node = @root.dfs(end_pos)
    trace_path_back(node)
  end

  def trace_path_back(node)
    path = []
    current_node = node
    while current_node.value != @root.value
      path.unshift(current_node.value)
      current_node = current_node.parent
    end
    path.unshift(@root.value)
    path
  end


end
