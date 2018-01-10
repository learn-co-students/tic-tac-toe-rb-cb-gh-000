board = [" "," "," "," "," "," "," "," "," "]

WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  "#{user_input}".to_i - 1
end

def move(board,index,value)
  board[index] = "#{value}"
  display_board(board)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if position_taken?(board, index) == true
    false
  elsif index > 9 || index < 0
    false
  else
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip.to_i

  index = input_to_index(user_input)

  if valid_move?(board, index)
    move(board,index, current_player(board))
  else
    puts "Please enter 1-9:"
    user_input = gets.strip.to_i
  end
end

def turn_count(board)
  board.count { |x| x != " " }
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
    win_combinations = []
    i = 0
  while i < WIN_COMBINATIONS.length do
      win_combinations = WIN_COMBINATIONS[i]
    position_1 = board[win_combinations[0]]
    position_2 = board[win_combinations[1]]
    position_3 = board[win_combinations[2]]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combinations
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combinations
    else
        false
    end
    i += 1
  end
end

def full?(board)
  if board.include?(" ")
    false
  else
    true
  end
end

def draw?(board)
  if won?(board) || full?(board) == false
    false
  else
    true
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  end
end

def winner(board)
  if won?(board)
    win_combination = won?(board)
    return board[win_combination[0]]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
