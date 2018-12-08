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

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  board[index] != " " && board[index] != nil
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  counter = 0
  board.each do |element|
    if (element == "X") || (element == "O")
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index1 = win_combination[0]
    win_index2 = win_combination[1]
    win_index3 = win_combination[2]

    ( board[win_index1] == "X" && board[win_index2] == "X" && board[win_index3] == "X" ) ||
    ( board[win_index1] == "O" && board[win_index2] == "O" && board[win_index3] == "O" )

  end
end

def full?(board)
  board.all? do |element|
    position_taken?(board, board.index(element))
  end
end

def draw?(board)
  !(!!won?(board)) && full?(board)
end

def over?(board)
  !!won?(board) || draw?(board) || full?(board)
end

def winner(board)
  !!won?(board) ? board[won?(board)[0]] : nil
end

def turn(board)
  puts "Please enter 1-9: "
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, value=current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  while !over?(board)
	   turn(board)
  end

  if !!won?(board)
	   puts "Congratulations #{winner(board)}!"
  elsif full?(board)
	   puts "Cat's Game!"
  end

end
