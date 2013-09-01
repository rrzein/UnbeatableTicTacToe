class Board
  attr_reader :rows

  def self.blank_grid
    (0...3).map { [nil] * 3 }
  end

  def initialize(rows = self.class.blank_grid)
    @rows = rows
  end

  def display
    2.downto(0) do |i|
      first = @rows[0][i] || "_"
      second = @rows[1][i] || "_"
      third = @rows[2][i] || "_"
      puts " #{i + 1} | #{first} | #{second} | #{third} |"
    end
    puts "   | 1 | 2 | 3 |"
  end

  def dup
    duped_rows = rows.map(&:dup)
    self.class.new(duped_rows)
  end

  def open?(pos)
    self[pos].nil?
  end

  def []=(pos, mark)
    x, y = pos[0], pos[1]
    @rows[x][y] = mark
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @rows[x][y]
  end

  def cols
    cols = [[], [], []]
    @rows.each do |row|
      row.each_with_index do |mark, col|
        cols[col] << mark
      end
    end

    cols
  end

  def diagonals
    down_diag = [[0, 0], [1, 1], [2, 2]]
    up_diag = [[0, 2], [1, 1], [2, 0]]

    [down_diag, up_diag].map do |diag|
      diag.map { |x, y| @rows[x][y] }
    end
  end

  def winner
    (rows + cols + diagonals).each do |triple|
      return :x if triple == [:x, :x, :x]
      return :o if triple == [:o, :o, :o]
    end

    nil
  end

end