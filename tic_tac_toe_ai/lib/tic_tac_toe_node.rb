require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []

    (0..2).each do |row|
      (0..2).each do |col|
        pos = [row, col]

        if !@board.empty?(pos)
          next
        end

        new_board = board.dup
        new_board[pos] = self.next_mover_mark
        next_mover_mark = :o if self.next_mover_mark == :x
        next_mover_mark = :x if self.next_mover_mark == :o

        children << TicTacToeNode.new(new_board, next_mover_mark, pos)
      end
    end

    children
  end

end
