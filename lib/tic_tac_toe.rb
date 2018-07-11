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

def input_to_index(input)
  input = input.to_i
  input = input - 1
end

def move (board, index, character )
  board[index] = character
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " "
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index.between?(0,8)
    if !position_taken?(board, index)
      true
    else
      false
    end
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  while !valid_move?(board, index) do
    if !valid_move?(board,index)
      puts "Try Again!"
    end
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)

  end
  move(board, index, current_player(board))


end


def turn_count(board)
  turn_counter  = 0
  board.each do |position|
    if position != " "
      turn_counter += 1
    end
  end
turn_counter
end

def current_player(board)

  if turn_count(board).even?
    turn = "X"
  else
    turn = "O"
  end
turn
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|

    if board[win_combination[0]] == "X" &&  board[win_combination[1]]  == "X" &&  board[win_combination[2]]  == "X"
      return win_combination
    elsif board[win_combination[0]] == "O" &&  board[win_combination[1]]  == "O" &&  board[win_combination[2]]  == "O"
      return win_combination
    else
      false
    end
  end
  false
end

def full?(board)
  if board.include?(" ")
    false
  else
    true
  end
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
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
    index = won?(board)
    if board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  else
    return nil
  end
end

def play(board)

  until over?(board)
    turn(board)
    display_board(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
    nil
  end
end
