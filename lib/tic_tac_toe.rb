WIN_COMBINATIONS = [
 [0,1,2], # Top row
 [3,4,5],  # Middle row
 [6,7,8],
 [0,4,8],
 [2,4,6],
 [0,3,6],
 [1,4,7],
 [2,5,8]
]

def input_to_index(num)
  num.to_i - 1
end

def full?(board)
 board.each do |cell|
   if(cell == " ")
     return false
   end
 end
 return true
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def draw?(board)
 return full?(board) && !won?(board)
end

def won?(board)
 WIN_COMBINATIONS.each do |win_combination|
   # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
   # grab each index from the win_combination that composes a win.
   win_index_1 = win_combination[0]
   win_index_2 = win_combination[1]
   win_index_3 = win_combination[2]

   position_1 = board[win_index_1] # load the value of the board at win_index_1
   position_2 = board[win_index_2] # load the value of the board at win_index_2
   position_3 = board[win_index_3] # load the value of the board at win_index_3

   if (position_1 == "X" && position_2 == "X" && position_3 == "X")then
     return win_combination
   elsif (position_1 == "O" && position_2 == "O" && position_3 == "O") then
     return win_combination
   end
 end
 if !full?(board) then return false end
 return nil
end

def over?(board)
 if(won?(board) || draw?(board) || full?(board)) then
   return true
 else
   return false
 end
end

def winner(board)
 WIN_COMBINATIONS.each do |win_combination|
   # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
   # grab each index from the win_combination that composes a win.
   win_index_1 = win_combination[0]
   win_index_2 = win_combination[1]
   win_index_3 = win_combination[2]

   position_1 = board[win_index_1] # load the value of the board at win_index_1
   position_2 = board[win_index_2] # load the value of the board at win_index_2
   position_3 = board[win_index_3] # load the value of the board at win_index_3

   if (position_1 == "X" && position_2 == "X" && position_3 == "X")then
     return "X"
   elsif (position_1 == "O" && position_2 == "O" && position_3 == "O") then
     return "O"
   end
 end
 return nil
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  return board[index] != " "
end

def valid_move?(board, index)
  return index >= 0 && index <= 8 && !position_taken?(board, index)
end

def turn_count(board)
 cont = 0
 board.each do |cell|
   cont = cont + (if cell == " " then 0 else 1 end)
 end
 return cont
end

def current_player(board)
   count = turn_count(board)
   if(count % 2 == 0) then "X" else "O" end
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index) then
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  while(!over?(board)) do
    turn(board)
  end
  if(draw?(board)) then
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end

 end
