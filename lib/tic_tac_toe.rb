
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]


WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  input = user_input.to_i - 1
  if !input.instance_of? Fixnum
    return -1
  else
    return input
  end
end

def move(board, index,  current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8) == false || position_taken?(board,index) == true
    return false
  else
    return true
  end
end

def turn(board)
  puts ("Please enter 1-9:")
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board,index, current_player(board))
    display_board(board)
  else
    puts ("Please enter 1-9:")
    input = gets.strip
    index = input_to_index(input)
  end
end

def turn_count(board)
  counter = 0
  board.each do |x_o|
    x_o == "X" || x_o == "O" ? counter += 1 : counter
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
   WIN_COMBINATIONS.each do |combination|
     win_index_1 = combination[0]
     win_index_2 = combination[1]
     win_index_3 = combination[2]
     if board[win_index_1] == "X" && board[win_index_2] == "X" && board[win_index_3] == "X"
       return combination
     elsif board[win_index_1] == "O" && board[win_index_2] == "O" && board[win_index_3] == "O"
       return combination
     end
   end
   return false
 end

def full?(board)
board.all? do |i|
  if i == " " || i.nil?
    false
  else
    true
  end
end
end

def draw?(board)
if won?(board) == false && full?(board) == true
  return true
else
  return false
end
end

def over?(board)
if won?(board) == true || draw?(board) == true || full?(board) == true
  return true
else
  return false
end
end

def winner(board)
win_array = won?(board)
if !won?(board)
  return nil
elsif board[win_array[0]] == "X"
  return "X"
else
  return "O"
end
end

def play(board)
  counter = 0
  until counter == 9

      if over?(board)
        puts "Game is over"
        nil
      end

      if won?(board) == false
        if draw?(board)
          puts "Cats Game!"
          nil
        else
          turn(board)
        end
      else
        puts "Congratulations #{winner(board)}!"
        nil
      end
    counter += 1;
  end
end
