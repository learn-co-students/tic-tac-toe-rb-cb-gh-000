WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8],
  [0,3,6], [1,4,7], [2,5,8],
  [0,4,8], [2,4,6]
]

def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (user_input)
  user_input.to_i - 1
end

def move (board, index, token)
    board[index] = token
end

def position_taken? (board, index)
  board[index] == 'X' || board[index] == 'O'
end

def valid_move? (board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn_count  (board)
  board.select do |position|
    position == 'X' || position == 'O'
  end.length
end

def current_player (board)
  if turn_count(board)%2 == 0
    'X'
  else
    'O'
  end
end

def turn (board)
  valid_move = false
  until valid_move
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    valid_move = valid_move?(board, index)
  end
  player_char = current_player(board)
  move(board, index, player_char)
  display_board(board)
end

def won? (board)
  WIN_COMBINATIONS.find do |combination|
    position_taken?(board, combination[0]) && board[combination[0]] == board[combination[1]] && board[combination[0]] == board[combination[2]]
  end
end

def full? (board)
  (0...board.length).all? do |position|
    position_taken?(board, position)
  end
end

def draw? (board)
  !won?(board) && full?(board)
end

def over? (board)
  won?(board) || draw?(board)
end

def winner (board)
  board[won?(board)[0]] if won?(board)
end

def play (board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end