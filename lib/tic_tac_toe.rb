# Helper Methods
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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
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

# Define your play method below
def play(board)
  until (over?(board))
    turn(board)
  end
  win = winner(board)
  if win then
    puts "Congratulations #{win}!"
  else
    puts "Cats Game!"
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
];

def won?(board)
  board_positions = board_positions = get_board_positions(board)

  WIN_COMBINATIONS.each do |condition|
    exist = condition.all? { |e| board_positions.include?(e)  }
    if exist then
      if board[condition[0]] == board[condition[1]] && board[condition[2]] == board[condition[0]] then
        return condition
      end
    end
  end
  return nil
end

def get_board_positions(board)
  board_positions = Array.new
  index = 0
  board.each do |str|
    board_positions << index if position_taken?(board, index)
    index += 1
  end
  return board_positions
end

def full?(board)
  board_positions = get_board_positions(board)
  return board_positions.length == 9
end

def draw?(board)
  return full?(board) && !won?(board)
end

def over?(board)
  return full?(board) || won?(board) || draw?(board)
end

def winner(board)
  won = won?(board)
  return won ? board[won[0]] : nil
end

def turn_count(board)
  counter = 0
  board.each  do | pos |
    counter += (pos != " ") ? 1 : 0
  end
  return counter
end

def current_player(board)
  return turn_count(board).even? ? 'X' : 'O'
end
