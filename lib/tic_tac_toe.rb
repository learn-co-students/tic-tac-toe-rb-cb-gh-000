# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(index)
  number = index.to_i - 1
end

def move(board, index, character)
  board[index] = character;
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
    character = current_player(board)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn != " "
      counter += 1
    end
  end

  return counter
end

def current_player(board)
  counter = turn_count(board)
  if counter % 2 == 0
    turn = "X"
  else
    turn = "O"
  end
end

def won?(board)
  x_turns = x_index(board)
  o_turns = o_index(board)
  if x_turns.empty? && o_turns.empty?
    return nil
  end
  WIN_COMBINATIONS.detect do |win_combination|
    (x_turns & win_combination).sort == win_combination.sort || (o_turns & win_combination).sort == win_combination.sort
  end
end

def full?(board)
  empty_turns = board.select do |position|
    position.strip == ""
  end

  empty_turns.empty?
end

def draw?(board)
  (won?(board) == nil) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  x_turns = x_index(board)
  o_turns = o_index(board)
  winner = nil
  if won?(board) != nil
    if (x_turns & won?(board)).sort == won?(board).sort
      winner = "X"
    elsif (o_turns & won?(board)).sort == won?(board).sort
      winner = "O"
    end
  end
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end

  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cats Game!"
  end

end

def x_index(board)
  board.each_index.select do |i|
    board[i] == "X"
  end
end

def o_index(board)
  board.each_index.select do |i|
    board[i] == "O"
  end
end
