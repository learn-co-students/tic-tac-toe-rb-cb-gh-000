WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 3, 6], # Left column
  [1, 4, 7], # Middle column
  [2, 5, 8], # Right column
  [0, 4, 8], # Left horizontal
  [2, 4, 6]  # Right horizontal
].freeze

def display_board(board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts '-----------'
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts '----------'
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  board[index] == 'X' || board[index] == 'O' ? true : false
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0, 8)
end

def turn(board)
  puts 'Enter a move 1-9'
  positon = gets.strip
  position = input_to_index(positon)
  valid_move?(board, position) ? move(board, position, current_player(board)) : turn(board)
  display_board(board)
end

def turn_count(board)
  board.count { |token| token == 'X' || token == 'O'}
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all? { |x| x == 'X' || x == 'O'}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if win_char = win_char = won?(board)
    board[win_char.first]
  end
end