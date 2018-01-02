WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  board[index] != "" && board[index] != " " && board[index] != nil
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board,index) ? true : false
end

def turn(board)
  puts "Enter number between 1-9"
  input = gets.strip
  if valid_move?(board, input_to_index(input))
    board[input_to_index(input)] = current_player(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.reject{ |e| e == "" || e == " " || e == nil }.count
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

def won?(board)
  status = false
  WIN_COMBINATIONS.each do |i|
    if (board[i[0]] == "X" && board[i[1]] == "X" && board[i[2]] == "X") || (board[i[0]] == "O" && board[i[1]] == "O" && board[i[2]] == "O")
      return i
      break
    end
  end
  status
end

def full?(board)
  board.detect{ |e| e == "" || e == " " || e == nil } == nil ? true : false
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  winning_combination = won?(board)
  over?(board) ? board[winning_combination[0]] : nil
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cat's Game!"
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end
