def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

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
    if (board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && (board[combo[2]] == "O" || board[combo[2]] == "X"))
      return (combo)
    end
  end
  return (false)
end

def full?(board)
  all = board.select{|elem|  elem == "X" || elem == "O"}
  return (all.size == 9)
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  if (draw?(board) || won?(board))
    return (true)
  else
    return (false)
  end
end

def winner(board)
  combo = won?(board)
  if (combo)
    return (board[combo[0]])
  else
    return (nil)
  end
end

def turn_count(board)
  count = 0
  board.each do |cur_value|
    if cur_value == "X" || cur_value == "O"
      count += 1
    end
  end
  return (count)
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return ("X")
  else
    return ("O")
  end
end

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

def play(board)
  i = 0
  while i < 9
    if (!over?(board))
      turn(board)
    end
    i += 1
  end
  if (draw?(board))
    puts "Cats Game!"
  elsif (won?(board))
    puts "Congratulations #{winner(board)}!"
  end
  is_fool = full?(board)
end
