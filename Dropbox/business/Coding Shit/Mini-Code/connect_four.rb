#connect 4 console game
#matrix of 100 "-"
#x's and o's
#need method for placing a peice
#how do I wanna play this
#x for players, o for computer

class Gameboard
  attr_accessor :board

  def initialize(board = Array.new(10){Array.new(10, "-")})
    @board = board
  end

  def display(board)
    #if board[][] == x or o,
    #should still display that regardless

    0.upto(9) do |x|
      p board[x].join(" ")
    end
  end

  def [](mark)
    board[mark[0]][board[1]]
  end

  def []=(mark,sym)
    board[mark[0]][board[1]] = sym
  end

  def place_token(marks,sym)
    #sym should just be an ex, once we write computer logic that will have an "o"
    board[marks] = sym
  end

  def available_moves(board)
    avail_moves = []

#from bottom up to ascertain where the token would "fall"
  9.downto(0) do |idx|
    board[idx].each_with_index do |x,i|
      # adds x,y unless it already has a token in it
        avail_moves << [idx,i] unless board[idx][i] != "-"
    end
  end

  # unique y values only
  avail_moves.uniq!{|move| move[1] }
  avail_moves
#drops token
# comp_move = avail_moves.sample
# board[comp_move[0]][comp_move[1]] = sym
  end

  def win(sym)

  win = false

    x_diff = 0
    y_diff = 0

    board.each_with_index do |x,i|
      current_row = board[i]
      next_row = board[i + 1]

      if current_row.include?(sym)
        if next_row.include?(sym)
          x_diff += 1 if current_row.index(sym) > next_row.index(sym)
            || current_row.index(sym) < next_row.index(sym)
          y_diff += 1
        else
          x_diff = current_row.count(sym)
        end
      end
    end


    case
      when x_diff.zero? && y_diff == 3
        win = true
      when x_diff == 4 && y_diff.zero?
        win = true
      when x_diff == 3 && y_diff == 3
        win = true
      else
        win
    end
  end

end

class ComputerPlayer
  def initialize(sym = "o");
      @@sym = sym
  end

  def parse_winning_moves
  end

  def get_move
  end
end

class HumanPlayer
  def initialize(sym = "x");
      @@sym = sym
  end

  def get_move
      puts "Enter your desired column"
      column = nil
      begin
        column = gets.chomp
          if column > 9 || column  < 0}
          puts "nope, not in range. Pick numbers from 0 to 9"
           raise
          end
      rescue
        retry
      end

      #interpret column choice into move
      slots = available_moves(board)
      move = slots.select{|slot| slot[1] == column}.flatten!

      [move, sym]
  end

    moves
  end
end

#only gonna be one against comp
class Gameplay
  attr_reader :board :player
   def initialize(board = Board.new, player = Player.new)
     @board = board
     @player = player
  end

  #just player turn
  #must write computer logic
  #which is exactly this tbh
  #but after humanplayer plays we switch

  def take_turn
    display(board)
    p "Let us begin!"
    move = player.get_move
    place_token(move,player.sym)
    display(board)
  end

  def play
    take_turn until board.win(sym)
    #if player wins, "congrats"
    #if player loses, "nice try bruh"
  end

end
