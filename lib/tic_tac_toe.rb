def display_board(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, position, char)
  board[position] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0, 8)
    !position_taken?(board, index)
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if !valid_move?(board, index)
    turn(board)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
  board.count{|position| position == "X" || position == "O"}
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

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

def won?(board)
  WIN_COMBINATIONS.each do |win_index|
    if board[win_index[0]] == "X" && board[win_index[1]] == "X" && board[win_index[2]] == "X"
      return win_index
    elsif board[win_index[0]] == "O" && board[win_index[1]] == "O" && board[win_index[2]] == "O"
      return win_index
    end
  end
  return false
end

def full?(board)
  board.all?{|position| position == "X" || position == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  winner = ""
  if won?(board)
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
