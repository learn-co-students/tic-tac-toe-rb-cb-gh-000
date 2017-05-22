
WIN_COMBINATIONS = [
  [0,4,8],
  [6,4,2],
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  return index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |symbol|
    if symbol == "X" || symbol == "O"
       counter += 1
    end
  end
  return counter

end

def current_player(board)
if turn_count(board) % 2 == 0
return "X"
elsif turn_count(board) % 2 == 1
return "O"
end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

   position_1 = board[win_index_1] # load the value of the board at win_index_1
   position_2 = board[win_index_2] # load the value of the board at win_index_2
   position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_taken?(board,win_index_1) && position_taken?(board,win_index_2) && position_taken?(board,win_index_3)
        if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
          return win_combination # return the win_combination indexes that won.
        else
          return false
        end
      end
  end
end

def full?(board)
  board.any? do |index|
     " " || "" || false
    end
    return !board.any?{|i| i == " "}
  end

def draw?(board)
   if !won?(board) && full?(board)
     return true
   elsif !won?(board) && !full?(board)
     return false
   elsif won?(board) && full?(board)
      return false
    end
  end

  def over?(board)
    if won?(board) || full?(board) && draw?(board)
      return true
      else
      return false
        end
  end
#============================================
  def winner(board)

    if won?(board)
      if board[won?(board)[0]] == "O"
        return "O"
      else
        return "X"
      end
    else
      return nil
    end

  end
  # Define your play method below
  def play(board)
  until over?(board) || won?(board) || draw?(board)
    turn(board)
  end
if won?(board)
    puts "Congratulations"
elsif draw?(board)
    puts "Cats Game!"
  end
  end
