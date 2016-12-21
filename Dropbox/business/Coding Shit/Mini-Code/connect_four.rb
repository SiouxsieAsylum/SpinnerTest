class GameBoard < Array

  attr_accessor :board

  def initialize(board = Array.new(10){Array.new(10, "-")})
    @board = board
  end

  def display
    row_nums = (0..9).to_a.join(" ")
    0.upto(9) do |x|
      p board[x].join(" ")
    end
    p row_nums
  end

  def place_token(marks,sym)
   begin
    board[marks[0]][marks[1]] = sym
   rescue
    puts "nope, not in range. Pick numbers from 0 to 9"
    end
  end

  def available_moves
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

  end

  def win(sym)

  win = false
    x_row_fill = false
    x_diff = 0
    y_diff = 0

    9.downto(0) do |i|
      current_row = board[i]
      next_row = board[i - 1]

      if current_row.include?(sym)
        start_sym = current_row.index(sym)
        end_sym = current_row.rindex(sym)
        sym_slice = current_row[start_sym..end_sym]

        if next_row.include?(sym)
          x_diff += 1 if start_sym > next_row.index(sym) || start_sym < next_row.index(sym)
          y_diff += 1
        else
            x_diff += current_row.count(sym)
        end

        sym_slice.uniq.length == 1 && sym_slice.length == 4 ? x_row_fill = true : x_row_fill
      end
    end

    case
      when x_diff == 1 && y_diff == 3
        win = true
      when x_row_fill
        win = true
      when x_diff == 3 && y_diff == 3
        win = true
      else
        win
    end

    win
  end

end

class HumanPlayer

  attr_accessor :sym

  def initialize(sym);
      @@sym = sym
  end

  def get_move
      puts "Enter your desired column"

        column = gets.chomp.to_i
      #interpret column choice into move
      column
  end

end

#only gonna be one against comp
class GamePlay
  attr_reader :board
  attr_accessor :player
   def initialize(board = GameBoard.new, player_1 = HumanPlayer.new("x"), player_2 = HumanPlayer.new("o"))
     @board = board
     @player_1 = player_1
     @player_2 = player_2
   end

  def take_turn_x

    column_x = @player_1.get_move
    slots_x = board.available_moves
    move_x = slots_x.select{|slot| slot[1] == column_x}.flatten!
    board.place_token(move_x, "x")
    board.display
  end

  def take_turn_o
      column_o = @player_2.get_move
      slots_o = board.available_moves
      move_o = slots_o.select{|slot| slot[1] == column_o}.flatten!
      board.place_token(move_o,"o")
      board.display
  end

  def play
  p "Let us begin!"
  board.display
    begin
      take_turn_x
       if @board.win("x")
         p "X Wins!"
         break
       end
      take_turn_o
       if @board.win("o")
         p "O Wins!"
         break
       end
    end while @board.win("x") == false && @board.win("o") == false

  end

end

connect = GamePlay.new()
connect.play
