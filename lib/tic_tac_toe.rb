def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    ["X", "O"].each do |mark|
      if combo.all?{|i| board[i] == mark}
        return combo
      end
    end
  end
  return nil
end

def full?(board)
  !board.any? { |e| e == " " }
end

def draw?(board)
  full?(board) && ! won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  winner = won?(board)
  if winner
    return board[winner[0]]
  else
    return nil
  end
end

def turn_count(board)
  mvcount = 0
  board.each do |mv|
    if mv == "X" || mv == "O"
      mvcount += 1
    end
  end
  return mvcount
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return input.to_i - 1
end

def valid_move?(board, index)
  if !index.between?(0, board.length - 1)
    return false
  elsif board[index] == " " || board[index] == "" || board[index] == nil
   return true
  else
   return false
  end
end

def move(board, index, piece)
  board[index] = piece
end

def turn(board)
  is_valid = false
  until is_valid do
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    is_valid = valid_move?(board, index)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    game_winner = winner(board)
    puts "Congratulations #{game_winner}!"
  else
    puts "Cat's Game!"
  end
end
