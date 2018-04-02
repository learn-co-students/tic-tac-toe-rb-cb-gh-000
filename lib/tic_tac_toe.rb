# Helper Method

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]


def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end


def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
      if (board[combination[0]]=="O" && board[combination[1]]=="O" && board[combination[2]]=="O") ||
         (board[combination[0]]=="X" && board[combination[1]]=="X" && board[combination[2]]=="X")
          return combination
      end
    end
    return false
  end

def full?(board)
  index=0
  while index<9
    if !position_taken?(board,index)
      return false
    end
    index +=1
  end
    return true
end


def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end


def over?(board)
  if won?(board)||draw?(board)||full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  array=won?(board)
  if array!=false
    return board[array[0]]
  else
    return nil
  end
end

def play(board)
  if won?(board)
    winner=winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
    puts "Where would you like to go?"
    input = gets
    index=input_to_index(input)
    if valid_move?(board,index)
      move(board,index,current_player(board))
      display_board(board)
      play(board)
    end

  end
end



# def play(board)
#   if won?(board)
#     winner=winner(board)
#     puts "Congratulations #{winner}!"
#   elsif draw?(board)
#     puts "Cat's Game!"
#   else
#   puts "Where would you like to go?"
#   input = gets
#   index=input_to_index(input)
#   if valid_move?(board,index)
#     if won?(board)
#       winner=winner(board)
#       puts "Congratulations #{winner}!"
#     elsif draw?(board)
#       puts "Cat's Game!"
#     else
#
#       move(board,index,current_player(board))
#       display_board(board)
#       play(board)
#     end
#   end
# end
# end
