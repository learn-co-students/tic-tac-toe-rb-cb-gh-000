# Helper Method

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i  - 1
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def position_taken?(board, index)
  board[index] != "" && board[index] != " " && board[index] != nil
end

def move(board, index, player)
    board[index] = player
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board, index, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  board.select do |position|
    !position.nil? && position != " " && position != ""
  end
  .length
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #first column
  [1,4,7], #middle column
  [2,5,8], #last column
  [0,4,8], #primary diagonal
  [2,4,6]  #secondary diagonal
]

def won?(board)
  WIN_COMBINATIONS.find { |combination| (combination.all? { |index|
  position_taken?(board,index) && board[index] == "X"  }) || (combination.all? { |index|
  position_taken?(board,index) && board[index] == "O"  })
}
end

def full?(board)
  board.all? do |position|
    !(position.nil? || position == " ")
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
   draw?(board) || won?(board)
end

def winner(board)
  over?(board) && won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if winner(board) != nil
    puts("Congratulations #{winner(board)}!")
  else
    puts("Cat's Game!")
  end

end
