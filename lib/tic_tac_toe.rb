# WIN_COMBINATIONS constant for all possible solutions
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display_board(board)
  separator = "-----------"
  row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row3 = " #{board[6]} | #{board[7]} | #{board[8]} "
  result = "#{row1}\n#{separator}\n#{row2}\n#{separator}\n#{row3}\n"
  print result
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each {|x| counter += 1 if x == 'X' || x == 'O'}
  counter
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |arr|
    temp = []
    arr.each {|i| temp << board[i]}
    result = temp.join
    if result == "XXX" || result == "OOO"
      return arr
    end
  end
  return false
end

def full?(board)
  board.all? {|x| x == "O" || x == "X"}
end

def draw?(board)
  !won?(board) && full?(board)
end
def player_move(board, position, token)
if valid_move?(board,position)
  board[position] = token
end
return board
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  result = won?(board)
  board[result[0]] unless result == false
end

def play(board)
  until over?(board)
    turn(board)
  end
  result = winner(board)
  if !result.nil?
    puts "Congratulations #{result}!"
  else
    puts "Cat's Game!"
  end
end
