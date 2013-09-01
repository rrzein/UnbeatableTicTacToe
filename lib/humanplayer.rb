class HumanPlayer
  def initialize(mark)
    @mark = mark
  end

  def move(game)
    game.display
    while true
      puts "Please enter coordinates to make a move in the following form: <Row #>, <Column #>"
      puts "Please note that rows and columns are numbered from 1 to 3, respectively."
      x, y = gets.chomp.gsub(/\s/, "").split(",").map(&:to_i)
      x -= 1
      y -= 1

      if HumanPlayer.valid_input?(x, y)
        return [x, y]
      else
        puts "Invalid coordinates. Please re-enter."
      end
    end
  end

  def self.valid_input?(x, y)
    [x, y].all? { |coord| (0..2).include?(coord) }
  end

end