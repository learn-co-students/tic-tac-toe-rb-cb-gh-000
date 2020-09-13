def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

 # Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

 def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

 def input_to_index(index)
  if index.to_i.to_s == index
    index = index.to_i
    index = index - 1
  else
    index = -1
  end
end

 def valid_move?(board, index)
  if position_taken?(board, index)
    false
  else
    if index > 9 || index < 0
      false
    else
      true
    end
  end
end

 def move(board, index, value)
  board[index]=value
end

 def turn(board)
  puts "Please enter 1-9:"
  index = gets.strip
  index = input_to_index(index)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    while !valid_move?(board, index)
      puts "Please enter 1-9:"
      index = gets.strip
      index = input_to_index(index)
    end
    move(board, index, current_player(board))
    display_board(board)
  end
end

 def turn_count(board)
  turns = 0
  board.each do |space|
    if space == "X" || space == "O"
      turns += 1
    end
  end
  return turns
end

 def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 1
    "O"
  else
    "X"
  end
end

 def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if !position_taken?(board, win_index_1) || !position_taken?(board, win_index_2) || !position_taken?(board, win_index_3)
       false
    else
      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
      else
        false
      end
      if position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      else
        false
      end
    end
  end
  return false
end

 def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
  end
end

 def draw?(board)
  game_won = won?(board)
  if game_won
    return false
  elsif !full?(board)
    return false
  elsif full?(board) && !game_won
    return true
  end
end

 def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  else
    false
  end
end

 def winner(board)
  if won?(board)
    winning_board = won?(board)
    board[winning_board[0]]
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
