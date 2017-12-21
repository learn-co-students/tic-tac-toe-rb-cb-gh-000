
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
  input = user_input.to_i
  if input > 0 && input<=100
    return input -1
  end
  return -1
end

def move(board,position,player)
  if valid_move?(board,position)
    board[position]=player
  else
    puts "Invalid move"
    turn(board)
  end
end

def position_taken?(board,position)
  return board[position] == "X" || board[position] == "O"
end

def valid_move?(board,position)
  return !position_taken?(board,position) && position>=0 && position<board.length
end

def turn(board)
  display_board(board)
  puts "Enter number"
  input = gets.strip
  index = input_to_index(input)
  move(board,index,current_player(board))
end

def turn_count(board)
  turn_count = 0
  board.each do |position|
    if position == "X" || position == "O"
      turn_count+=1
    end
  end
  return turn_count
end

def current_player(board)
  if turn_count(board)%2==0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  return WIN_COMBINATIONS.detect do |combination|
    position_taken?(board, combination[0]) && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]
  end
end

def full?(board)
  return board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  return !won?(board) && full?(board)
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
  return nil
end

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
