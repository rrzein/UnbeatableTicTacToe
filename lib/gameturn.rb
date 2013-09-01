class GameTurn
  attr_reader :board, :possible_moves

  def initialize(current_player, computer_player, board = Board.new)
    @board = board
    @current_player = current_player
    @computer_player = computer_player
    @possible_moves = []
  end

  def best_move
    @possible_moves.max{ |a, b| a.turn_score <=> b.turn_score }
  end

  def turn_score
    if game_over?
      return 0 if tied?
      return (winner == @computer_player) ? 1 : -1
    end

    scores = @possible_moves.map { |move| move.turn_score }
    (@current_player == @computer_player) ? scores.max : scores.min
  end

  def generate_moves
    next_player = ((@current_player == :x) ? :o : :x)
    @board.rows.each_with_index do |row, r|
      row.each_with_index do |column, c|
        if column.nil?
          next_board = @board.dup
          position = [r,c]
          next_board[position] = @current_player

          next_node = GameTurn.new(next_player, @computer_player, next_board)
          @possible_moves << next_node
          next_node.generate_moves
        end
      end
    end
  end

  def game_over?
    won? || tied?
  end

  def won?
    !winner.nil?
  end

  def tied?
    return false if won?
    @board.rows.all? { |row| row.none? { |el| el.nil? }}
  end

  def winner
    @board.winner
  end

  def open?(coords)
    @board.open?(coords)
  end

end