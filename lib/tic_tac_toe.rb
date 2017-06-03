WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
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

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  input = input_to_index(input)
  if valid_move?(board,input)
    move(board,input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.find { |win_combination|
    board[win_combination[0]] == "X" &&
    board[win_combination[1]] == "X" &&
    board[win_combination[2]] == "X" ||
    board[win_combination[0]] == "O" &&
    board[win_combination[1]] == "O" &&
    board[win_combination[2]] == "O"
  }
end

def full?(board)
  board.all? { |space| space == "X" || space == "O" } ? true : false
end


def draw?(board)
  !won?(board) && full?(board) ? true : false
end

def over?(board)
  won?(board) || draw?(board) ? true : false
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
