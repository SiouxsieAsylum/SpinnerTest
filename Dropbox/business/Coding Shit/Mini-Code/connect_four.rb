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

  def won?
    #won 4 in a row diagonally, forwards to back, up to down
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
      puts "Enter coordinates x,y with a comma in between"
       moves = []
      begin
        input = gets.chomp
        move = input.split(",").map!{|n| n.to_i}
          if move.any?{|i| i > 9 || i < 0}
          puts "nope, not in range. Pick numbers from 0 to 9"
           raise
          end
      rescue
        retry
      end
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
    begin
      move = player.get_move
       if board[move] == "-"
         #will this work?

         place_token(move,player.sym)
       else
         p "spot taken, pick another"
         retry
       end

     end
    display(board)
  end

  def play
    take_turn until board.won?
    #if player wins, "congrats"
    #if player loses, "nice try bruh"
  end

end
