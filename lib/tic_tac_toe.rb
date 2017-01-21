WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2] ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  return board[index] != " "
end

def valid_move?(board, index)
  if index.between?(0,8)
    return !position_taken?(board, index)
  end
  return false
end

def turn(board)
  puts "Enter 1-9:"
  user_input = gets.strip

  loop do
    if !input_to_index(user_input).between?(0,8)
      puts "Invalid Input! Try Again"
      puts "Enter 1-9:"
      user_input = gets.strip
      next
    end

    index = input_to_index(user_input)

    if !valid_move?(board, index)
      puts "Invalid Move! Try Again"
      next
    end

    move(board, index, current_player(board))
    break
  end
end

def turn_count(board)
  count = 0
  board.each do |token|
    if token != " "
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

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if combo.all? { |index| board[index] == "X" }
      return true
    elsif combo.all? { |index| board[index] == "O" }
      return true
    end
  end
  return false
end

def full?(board)
  return board.none? { |token| token == " " }
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
  return false
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  if draw?(board)
    return nil
  end

  if won?(board)
    WIN_COMBINATIONS.each do |combo|
      if combo.all? { |index| board[index] == "X" }
        return "X"
      elsif combo.all? { |index| board[index] == "O" }
        return "O"
      end
    end
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end

  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end