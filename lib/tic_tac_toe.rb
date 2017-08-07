# win combos
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,4,8], # diagonal 1
  [2,4,6], # diagonal 2
  [0,3,6], # vertical 1
  [2,5,8], # vertical 2
  [1,4,7] # vertical 3
]

# display board
def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
 end

 board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  display_board(board)

  # input_to_index and move
  def input_to_index(input)
    input.to_i - 1
  end

  def move(board, index, char)
    board[index] = char
    return board
  end

  # position_taken?
  def position_taken?(board, index)
    if board[index] == " " || board[index] == "" || board[index] == nil
      return false
    elsif board[index] == "X" || board[index] == "O"
      return true
    end
  end

  # valid_move?
  def valid_move?(board, index)
    if(index >= 0 ) && (index <= 8)
       if position_taken?(board, index)
         return false
         puts "That position is already taken"
       else
         return true
       end
     else
      return false
     end
   end

# turn
def turn(board)
  puts "Please enter 1-9:"
    usr_input = gets.strip
    alt_input = input_to_index(usr_input)
    if valid_move?(board, alt_input)
      move(board,alt_input, current_player(board))
    else
      turn(board)
    end
  display_board(board)
end

#turn count
def turn_count(board)
  turns_played = 0
   board.each do |index|
     if index != " "
       turns_played += 1
     end
   end
   return turns_played
end

#current player
def current_player(board)
  turns_played = turn_count(board)
  if turns_played % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_positions = [board[win_combination[0]], board[win_combination[1]], board[win_combination[2]]]
    if win_positions == ["X","X","X"] || win_positions == ["O","O","O"]
      return win_combination
    end
  end
  return false
end

def full?(board)
  !board.any?{|position| position == " " || position == nil}
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  end
end

def over?(board)
  if won?(board) == true || full?(board) == true || draw?(board) == true
    return true
  end
end

def winner(board)
  if won?(board) != false
    return board[won?(board)[0]]
  else
   return nil
 end
end

def play(board)
   until over?(board) == true || draw?(board) == true || won?(board) != false
     turn(board)
   end

   if won?(board) != false
     puts "Congratulations " + winner(board) + "!"
   else
     puts "Cats Game!"
   end
 end
