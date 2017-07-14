WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
].freeze

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts '-----------'
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts '-----------'
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

def input_to_index(position)
  position.to_i - 1
end

def won?(board)
  WIN_COMBINATIONS.detect do |win|
    board[win[0]] == board[win[1]] &&
    board[win[1]] == board[win[2]] &&
    position_taken?(board, win[0])
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def turn(board)
  puts 'Please enter 1-9:'
  position = gets.strip
  index = input_to_index(position)
  valid_move?(board, index) ? move(board, index, current_player(board)) : turn(board)
  display_board(board)
end

def position_taken?(board, index)
  board[index] != ' ' ? true : false
end

def current_player(board)
  (turn_count(board) % 2).zero? ? 'X' : 'O'
end

def turn_count(board)
  count = 0
  board.each do |token|
    token == 'X' || token == 'O' ? count += 1 : count
  end
  count
end

def move(array, index, player_token)
  array[index] = player_token
end

def winner(board)
  return unless winning_combo = won?(board)
  board[winning_combo.first]
end
