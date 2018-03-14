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
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  if board.all?{|position| position == " "}
    return false
  end

  WIN_COMBINATIONS.each do |combinations|
    if combinations.all?{|position| board[position] == "X"} ||
      combinations.all?{|position| board[position] == "O"}
      return combinations
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
  won?(board) ||draw?(board)
end

def winner(board)
  if !won?(board)
    return nil
  end

  if won?(board).all?{|position| board[position] == "X"}
    return "X"
  end

  if won?(board).all?{|position| board[position] == "O"}
    return "O"
  end
end

def turn_count(board)
  board.count{|position| position == "X" || position == "O"}
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def play(board)
  while !over?(board) do
    turn(board)
  end

  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
