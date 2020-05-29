
WIN_COMBINATIONS = [
  [0, 1, 2], # horizontal top
  [3, 4, 5], # horizontal middle
  [6, 7, 8], # horizontal bottom

  [0, 3, 6], # vertical left
  [1, 4, 7], # vertical middle
  [2, 5, 8], # vertical  right

  [0, 4, 8], # diagonal left
  [2, 4, 6]  # diagonal right
]

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

# board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# for player, board contains spaces 1-9, but array is 0-8
def input_to_index(input)
  # input is string; we convert to integer
  input.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

# if the position is free, the method should return false
# so if position is not free, return true
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# move is present on board && not already filled
# returns true if the move is valid
def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

# ask player to make a turn and display new board if move valid
# if not valid, ask again
def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  move_count = 0
  board.each do |index|
    if index == "X" || index == "O"
      move_count += 1
    end
  end
  move_count
end

def turn_count(board)
  board.count{|i| i == "X" || i == "O"}
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# return false/nil if no win combinations present in the board
# return winning combination indexes as an array if there is a win
def won?(board)
    WIN_COMBINATIONS.detect do |combination|
      # if all parts of a win combination are the same, i.e. X or O or blank
      board[combination[0]] == board[combination[1]] &&
      board[combination[1]] == board[combination[2]] &&
      # and they are not blank, thus X or O
      position_taken?(board, combination[0])
      # detect will return first winning combination and nil otherwise
    end
end

# return true if every element in the board contains either an "X" or an "O"
def full?(board)
  board.all?{|i| i == "X" || i == "O"}
end

# returns true if the board has not been won and is full
# returns false if the board is not won and the board is not full
# returns false if the board is won
def draw?(board)
  !won?(board) && full?(board)
end

# returns true if the board has been won, is a draw, or is full
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

# return the token, "X" or "O" that has won the game given a winning board
def winner(board)
  # if there was a winning combination
  if won?(board)
    # get the first item in the winning combination (arbitrary) == all other items in the combination
    board[won?(board)[0]]
  end
end
