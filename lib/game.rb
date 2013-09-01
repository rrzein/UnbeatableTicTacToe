require_relative './gameturn'
require_relative './board'
require_relative './humanplayer'
require_relative './computerplayer'

class Game
  attr_accessor :players

  def initialize
    @turn = :x
    assign_players
    generate_game
    start
  end

  def display
    @game_turn.board.display
  end

  def assign_players
    while true
      puts "First player (X) or second player (O)? Enter 'X' or 'O'."
      mark = gets.chomp.downcase.to_sym
      if [:x, :o].include?(mark)
        human_player = HumanPlayer.new(mark)
        computer_mark = ((mark == :x) ? :o : :x)
        computer_player = ComputerPlayer.new(computer_mark)
        
        @players = { mark => human_player, computer_mark => computer_player }

        return
      else
        puts "Invalid entry. Please re-enter."
      end
    end
  end

  def generate_game
    computer_mark = ((@players[:x].is_a?(ComputerPlayer)) ? :x : :o)
    @game_turn = GameTurn.new(:x, computer_mark)
    @game_turn.generate_moves
  end

  def start
    until @game_turn.game_over?
      player_turn
    end

    display
    if @game_turn.won?
      puts "#{@game_turn.winner.to_s.upcase} wins."
    else
      puts "Draw."
    end
  end

  def player_turn
    player = @players[@turn]
    @game_turn = (player.is_a?(HumanPlayer)) ? human_turn : computer_turn
    @turn = ((@turn == :x) ? :o : :x)
  end

  def human_turn
    while true
      move_coords = @players[@turn].move(self)
      break if @game_turn.open?(move_coords)
      puts "Space is not empty."
    end

    next_turn = @game_turn.possible_moves.find do |game_turn|
      game_turn.board[move_coords] == @turn
    end

    next_turn
  end

  def computer_turn
    @game_turn.best_move
  end

end