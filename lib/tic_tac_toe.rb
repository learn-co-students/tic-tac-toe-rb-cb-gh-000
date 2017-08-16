# Helper Method
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

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  char = current_player(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn_count(board)
  count = 0
  board.each do |spaces|
    if(spaces == "X" || spaces == "O")
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def success?(board, array)
  pos0 = board[array[0]]
  pos1 = board[array[1]]
  pos2 = board[array[2]]
  ((pos0 == "X" && pos1 == "X" && pos2 == "X") || (pos0 == "O" && pos1 == "O" && pos2 == "O"))
end

def won?(board)
  WIN_COMBINATIONS.detect do |array|
    success?(board, array)
  end
end

def full?(board)
  i = 0
  full = true
  while i < 9
    if !position_taken?(board, i)
      full = false
    end
    i += 1
  end
  full
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if (won?(board))
    pos = won?(board)[0]
    board[pos]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if(won?(board))
    char = winner(board)
    puts "Congratulations #{char}!"
  else
    puts "Cats Game!"
  end
end
