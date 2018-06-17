

WIN_COMBINATIONS = [
  [0, 1, 2], #Top row
  [3, 4, 5], #Middle row
  [6, 7, 8], #Bottom row
  [0, 4, 8], # left to right Diagonal
  [2, 4, 6], #right to left diagonal
  [0, 3, 6], #left column
  [1, 4, 7], #center column
  [2, 5, 8] #right column
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

def move(board, index, value)
  board[index] = value
end

def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board, index) != true
    return true
  end
  return false
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |square|
    if square == "X" || square == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if combination.all?{|index|  board[index] == "X"} || combination.all?{|index| board[index] == "O"}
      return combination
    end
  end
  return false
end

def full?(board)
  board.all?{|space| (space == "X" || space == "O")}
end

def draw?(board)
  result = false
  if won?(board)
    result = false
  elsif full?(board)
    result = true
  else
    result = false
  end
end

def over?(board)
  full?(board) || draw?(board) || won?(board)
end

def winner(board)
  result = nil
  if over?(board)
    if won?(board)
      if (won?(board).all?{|index| board[index] == "X"})
        result = "X"
      else
        result = "O"
      end
    end
  end
  return result
end

def play(board)
  until over?(board)
    turn(board)
  end
  message = winner(board)
  if won?(board)
    puts "Congratulations #{message}!"
  else
    puts "Cat's Game!"
  end
end
