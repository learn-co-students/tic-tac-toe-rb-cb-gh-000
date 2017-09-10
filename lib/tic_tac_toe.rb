#all win combinations for the game
WIN_COMBINATIONS = [
  #across combinations
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row

  #up/down combinations
  [0, 3, 6], #left column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column

  #diagonal combinations
  [0, 4, 8], #diagonal topleft/bottomright
  [2, 4, 6] #diagonal bottomleft/topright

]

#displays the board layout to the user in the command line
def display_board(board)
  rows = [" #{board[0]} | #{board[1]} | #{board[2]} ", "-----------", " #{board[3]} | #{board[4]} | #{board[5]} ", "-----------", " #{board[6]} | #{board[7]} | #{board[8]} "]
  puts rows[0]
  puts rows[1]
  puts rows[2]
  puts rows[3]
  puts rows[4]
end

#converts string input from gets to an integer so it can be used to access array indices
def input_to_index(user_input)
  user_input.to_i - 1
end

#moves player marker (X or O) to their desired position on the board
def move(board, position, current_player)
  board[position] = current_player
end

#checks if the position is taken
def position_taken?(board, position)
  board[position] != " " && board[position] != ""
end

#checks if move is on the board or if the position is taken
def valid_move?(board, position)
  position.between?(0, 8) && !position_taken?(board, position)
end

#counts the number of turns that have been taken
def turn_count(board)
  count = 0
    board.each do |index|
      index == "X" || index == "O" ? count += 1 : nil
    end
    return count
  end

#determines the current player (X or O) - because X always goes first, #turn_count will always be uneven before X's go
def current_player(board)
  count = turn_count(board)
  if count.even?
    return "X"
  else
    return "O"
  end
end

#turn calls on the above helper methods to get input from the user and record a turn
def turn(board)
  player = current_player(board)
  got_valid = false
  puts "Please choose a position between 1-9:"
  while got_valid == false
    user_input = gets.strip
    position = input_to_index(user_input)
    if valid_move?(board, position)
      move(board, position, player)
      display_board(board)
      got_valid = true
    end
  end
end

#determines whether or not a player has won and returns the winning combination if there is a win and false if there isn't
def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    pos_one = win_combo[0]
    pos_two = win_combo[1]
    pos_three = win_combo[2]

    if board[pos_one] != " " && board[pos_one] == board[pos_two] && board[pos_two] == board[pos_three]
      return win_combo
    end
  end
  false
end

#returns true if the board is full (draw)
def full?(board)
  !board.include?(" ")
end

#returns true if the board has not been won but is full, false if the board is not won and the board is not full, and false if the board is won
def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
  else
    false
  end
end

#returns true if the game is ovr (win/draw)
def over?(board)
  if won?(board) || draw?(board)
    true
else
  false
  end
end

#returns the current player (X or O) depending on who won
def winner(board)
  if won?(board) && board[won?(board)[0]] == "X"
    return "X"
  elsif won?(board) && board[won?(board)[0]] == "O"
    return "O"
  end
end

#the play method is the method that rus the game using the helpr methods
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


board = ["X", "X", " ", " ", " ", " ", " ", " ", " "]
winner(board)
