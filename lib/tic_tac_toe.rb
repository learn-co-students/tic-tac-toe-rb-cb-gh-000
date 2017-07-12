def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def won?(board)
  WIN_COMBINATIONS.each do |win_p|
    win_ind1 = win_p[0]
    win_ind2 = win_p[1]
    win_ind3 = win_p[2]

    position_1 = board[win_ind1]
    position_2 = board[win_ind2]
    position_3 = board[win_ind3]
    if position_1 == position_2 && position_1 == position_3 && position_1 != "" && position_1 != " " && position_1 != nil
      return win_p
    end
  end
  return false
end

def full?(board)
  return board.none? { |e|  e == "" || e == " " || e == nil}
end

def draw?(board)
  return !won?(board) && full?(board)
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  if winner = won?(board)
    return board[winner[0]]
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def play(board)
  until over?(board) || won?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    if turn_count(board) % 2 == 0
      move(board, index, "X")
    else
      move(board, index, "O")
    end
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |cell|
    if cell == "X" || cell == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end
