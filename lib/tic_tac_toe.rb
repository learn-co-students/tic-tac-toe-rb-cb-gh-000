WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]

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

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  !(board[index] == "" || board[index] == " ")
end

def valid_move?(board, index)
  if position_taken?(board, index) || index > 8 || index < 0
    false
  else
    true
  end
end

def turn(board)
  puts "Please input a number 1-9"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combinations|
    index1 = win_combinations[0]
    index2 = win_combinations[1]
    index3 = win_combinations[2]

    position1 = board[index1]
    position2 = board[index2]
    position3 = board[index3]

    if position1 == "X" && position2 == "X" && position3 == "X"
      return win_combinations
    elsif position1 == "O" && position2 == "O" && position3 == "O"
      return win_combinations
    end
  end
  false
end

def full?(board)
  board.all? { |character| character == "X" || character == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  output = won?(board)
  if output.class == Array
    return board[output[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board) != nil
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
