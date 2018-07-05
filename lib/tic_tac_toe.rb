
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if(draw?(board))
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
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

def turn_count(board)
  turn = 0
  board.each do |pos|
    if pos == 'X' || pos == 'O'
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  if(turn_count(board) % 2 == 0)
    return 'X'
  else
    return 'O'
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
  win = false
  WIN_COMBINATIONS.each do |win_combination|
    if position_taken?(board,win_combination[0]) && board[win_combination[0]] == board[win_combination[1]] && board[win_combination[0]] == board[win_combination[2]]
      return win_combination
      win = true
    end
  end
  if(!win)
    return false
  end
end

def full?(board)
  board.all? do |char|
    !(char == nil || char == " ")
  end
end

def draw?(board)
  !won?(board)
end

def over?(board)
  if full?(board)
   (draw?(board) || won?(board))
 elsif won?(board)
   return true
 else
   return false
 end
end

def winner(board)
  win_combination = won?(board)
  if win_combination != false
    return board[win_combination[0]]
  else
    nil
  end
end
