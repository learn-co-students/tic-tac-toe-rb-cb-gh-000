WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

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

def move(board, index, current_player )
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index , current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
board.each do |position|
  if position != " "
    count += 1
  end
end
return count
end

def won?(board)
      WIN_COMBINATIONS.each do |win_combo|
        index1 = win_combo[0]
        index2 = win_combo[1]
        index3 = win_combo[2]
        if board[index1] == "X" && board[index2] == "X" && board[index3] == "X"
          return win_combo
        end
        if board[index1] == "O" && board[index2] == "O" && board[index3] == "O"
          return win_combo
        end
      end
      else
    return false
end

def full?(board)
  if board.all?{|i| i == "X" || i == "O"}
    return true
  else
    return false
  end
end

def draw?(board)
  if !(won?(board)) && full?(board)
    return true
  else
    return false
  end
end


def over?(board)
  if won?(board)
    return true
  end
  if full?(board)
    return true
  end
  return false
end

def winner(board)
  if !(won?(board))
    return nil
  end

  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def current_player(board)
  if turn_count(board) % 2 == 1
    return "O"
  end
  if turn_count(board) % 2 == 0
    return "X"
  end
end

def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cat's Game!"
  end
end
