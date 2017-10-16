WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [2,4,6], #right to left diagonal
  [0,4,8], #left to right diagonal
  [0,3,6], #first column
  [1,4,7], #second column
  [2,5,8] #third column
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
  board[index] = current_player(board)
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

def turn_count(board)
  turn = board.count "X"
  turn2 = board.count "O"
  return turn + turn2
end

def current_player(board)
  who = turn_count(board) + 1
  if who.odd?
    return "X"
  elsif who.even?
    return "O"
  elsif who > 9
    return false
  end
end

def won?(board)
  index = []
  WIN_COMBINATIONS.each do |combo|
    combo.each do |pos|
      index.push(board[pos])
     end
    if index == ["X", "X", "X"] || index == ["O", "O", "O"]
     return combo
    else
     index.clear
    end
  end
  return false
end

def full?(board)
  board.all? {|pos| pos == "X" || pos == "O"}
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  end
end

def over?(board)
  if won?(board)
    return true
  elsif full?(board)
    return true
  elsif draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    index = won?(board)
    if board[index[0]] == "X"
      return "X"
    elsif board[index[0]] == "O"
      return "O"
    else
      return false
    end
  end
end

def play(board)
  while over?(board) == false && turn_count(board) < 10
        turn(board)
  end
  if won?(board)
    player = winner(board)
    puts "Congratulations #{player}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
