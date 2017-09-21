WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #horizontal middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column
  [0, 4, 8], #left diagonal
  [2, 4, 6]  #right diagonal
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

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  index <= 8 && index >= 0 == true &&
  position_taken?(board, index) == false
end

def move(board, index, character)
  board[index] = character
  display_board(board)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    board
  else valid_move?(board, index) == false
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |index|
    if index != "" && index != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).even?
    "X"
  elsif turn_count(board).odd?
    "O"
  end
end

def won?(board)
  board.all? {|i| i != " " || i != ""}
  winning_array = WIN_COMBINATIONS.detect do |win_array|
    if win_array.all? {|position| board[position] == "X" } == true
      winning_array.inspect
    elsif win_array.all? {|position| board[position] == "O" } == true
      winning_array.inspect
    end
  end
end

def full?(board)
  board.none? {|i| i == "" || i == " "}
end

def draw?(board)
   won?(board) == nil && full?(board) == true
end

def over?(board)
  if (draw?(board) == true) || (won?(board) != nil)
    over = true
  else
    over = false
  end
end

def winner(board)
  if won?(board) != nil
    winner = board[won?(board)[0]]
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if draw?(board) == true
      puts "Cats Game!"
  else puts "Congratulations #{winner(board)}!"
  end
end
