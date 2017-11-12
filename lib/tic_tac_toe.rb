WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

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

def move(board,index,player)
  board[index] = player
end

def position_taken?(board,position)
  board[position] == "X" || board[position]  == "O"
end

def valid_move?(board,position)
  position.between?(0,8) && !position_taken?(board,position)
end

def turn(board)
  puts "Please enter position between 1-9"
  position = input_to_index(gets.strip)
  until valid_move?(board,position)
    puts "Please enter position between 1-9"
    position = input_to_index(gets.strip)
  end
  player = current_player(board)
  move(board,position,player)
  display_board(board)
end

def turn_count(board)
  board.count{ |x| x == "X" || x == "O"}
end

def current_player(board)
  turn_count(board) % 2 == 0?"X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if (board[win_combination[0]]=="X" && board[win_combination[1]]=="X" && board[win_combination[2]]=="X") || (board[win_combination[0]]=="O" && board[win_combination[1]]=="O" && board[win_combination[2]]=="O")
      return win_combination
    end
  end
  false
end

def full?(board)
  board.count{|x| x == " "} == 0
end

def draw?(board)
 (!won?(board) && full?(board))
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  a = won?(board)
  !a ? nil : board[a[0]]
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
