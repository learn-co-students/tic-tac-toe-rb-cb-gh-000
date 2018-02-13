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


def play(board)
 while !over?(board)
   turn(board)
 end
 if won?(board)
   puts "Congratulations #{winner(board)}!"
 elsif draw?(board)
   puts "Cat's Game!"
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
  index = input.to_i
  index - 1
end

def move(board, index, token)
  board[index] = token
end

def valid_move?(board, index)
    if position_taken?(board, index)
      return false
    elsif index.between?(0, 8)
      return true
    elsif index.between?(0, 8) != position_taken?(board, index)
      return true
    else
        return false
    end
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end
end

def won?(board)

  WIN_COMBINATIONS.each do |combo|
    if position_taken?(board , combo[0]) && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
      return combo
    end
  end
return false
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
  return false
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def current_player(board)
  number_of_moves = turn_count(board)

  if number_of_moves % 2 == 0
    return "X"
  else
    return "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"

  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index) && position_taken?(board, index) == false
    move(board , index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)

  counter = 0

  board.each do |position|

      if position == "X" || position == "O"
        counter += 1
      end
  end
    return counter
  end
