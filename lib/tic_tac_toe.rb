WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8],
    [2, 4, 6], [0, 3, 6], [1, 4, 7], [2, 5, 8]
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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
    return !(board[index].nil? || board[index] == " ")
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
  counter = 0
  board.each do |spot|
    if (spot != " ")
      counter += 1
    end
  end
  return counter

end

def current_player(board)
  count = turn_count(board)
  return (count % 2 == 0) ? "X" : "O"

end

def won?(board)
  for win_combination in WIN_COMBINATIONS do
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X")
        return win_combination
      end
      if (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return win_combination
      end
  end
  return false
end

def full?(board)
  board.each do |element|
    if (element == " ")
      return false
    end
  end
  return true
end

def draw?(board)
  if (!won?(board) && full?(board))
    return true
  else
    return false
  end
end

def over?(board)
  if (won?(board) || draw?(board) || full?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if (over?(board))
    win_combination = won?(board)
    if (board[win_combination[0]] == "X")
      return "X"
    elsif (board[win_combination[0]] == "O")
      return "O"
    else
      return nil
    end
  end
end

def play(board)
  until (over?(board) == true)
    turn(board)
  end

  if (won?(board))
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
